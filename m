Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5D26B2DA;
	Sun, 23 Aug 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787491588; cv=none; b=mlB58FfBJCGoP9BbYuchTNvsk2sw1GafMDuArkmT1SnJZOoI9Y6CVPZLFG9NIIYoGQ234dq54r58V/x2wipLc5gH6u0ByO52qm1do5D3iNcoGcKLWPv/jECm1HzOVLwKxDXL3D6Ku9mk5btXnplckvAPd9hCH7NttBWVHrPVQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787491588; c=relaxed/simple;
	bh=LLil3BNrOwS4oB/WO/7UZRwGmFvoxGfKyZC6rJ6cgiI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OWLh037WOPc1EFIH80WBqnt3xXSG40GSjxPc7K7m2vwrvA5l5IPIeRkU2EgrZX4xmhDjRNOPwciHr1likAN66pZYKKf17H3e49nFDNBN6N7G3QszhUQHaz6hhvXlpqTMr0rm70MJWpOqmPFVBzMvC+a9+hkhsBOFWUMxb63X9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GuVTYcX1; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GuVTYcX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=s6ujjyzbpzcbdbrf3uxbov4fcq.protonmail; t=1787491576; x=1787750776;
	bh=YJeSJxmCxXY6wg5YkJ7iwTOO+NmlAZCtpTdM7AlaSH0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GuVTYcX19akfodFHVV5Aj+NxxZ7WptFBorOyrkViSXw6Ojxp+D9H5VJUfYIrJegOu
	 rxZzCsjdsUGbIFAnShjDulyYcPGerMFuWA5D+XToIwM8Y7PUokQAbi547TO9O4jaoy
	 OzKtQ53NsXrFwb3WAyEap3AlZ5S6whbZ/BaayroGTqhp0ykrsiy4NdbZwwIARhuoNA
	 /qboijB1bs4MzMvwUoX+aFstfHwBfMxG0gHYpSL0eg9aptCjU4lverSfGR5mWJUEpe
	 ekXK6K12JqPZ1/nuWOY6iFnQlvnmnqJ9QKDIZVtdLNP4OByLjFjSjhsUtvTOFJj7/5
	 Zi50O83g2yBVw==
Date: Sun, 23 Aug 2026 13:26:09 +0000
To: "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: nirbhayykumarr@proton.me
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w@1wt.eu" <w@1wt.eu>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] misc: mei: fix race condition between client teardown and read completion
Message-ID: <mFnbLgz6MmxRv7Vo5F8dRB1xDjHWEORPoX9BEIpeevk-ptyMfVaw-WDBSZq-4i4g8eR2HpVF9QNvtbxRcAxJE621Ji2caOLa-9xmEMmpIiw=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 5fda7c15271162e9122b5e4aad4c05ef3f1e87fc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_6aGEWYnXA4YCd2X7XBB112FT7dVczYYh6hc0pQUw5g"

--b1=_6aGEWYnXA4YCd2X7XBB112FT7dVczYYh6hc0pQUw5g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In mei_release(), a host client is torn down upon close(). During this
teardown sequence, mei_cl_disconnect() is invoked, which releases
dev->device_lock while waiting for the firmware response.

If an in-flight read request was previously submitted, an incoming
completion interrupt processed concurrently by the MEI interrupt
handler can add a completed callback into cl->rd_completed via
mei_cl_add_rd_completed().

Because mei_cl_flush_queues(cl, NULL) was invoked before mei_cl_unlink(cl),
an incoming completion callback can slip into cl->rd_completed after the
flush has completed but before the client is unlinked from dev->file_list.
When mei_cl_unlink() is subsequently called, the invariant check at
drivers/misc/mei/client.c:698 triggers:

  WARN_ON(!list_empty(&cl->rd_completed) ||
          !list_empty(&cl->rd_pending) ||
          !list_empty(&cl->link));

Call trace:
  WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unlink+=
0xaa/0x140 [mei]
  RIP: 0010:mei_cl_unlink+0xaa/0x140 [mei]
  Call Trace:
   <TASK>
   mei_release+0x202/0x270 [mei]
   __fput+0x105/0x2e0
   __x64_sys_close+0x90/0x140
   do_syscall_64+0xaa/0x660
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Immediately following mei_cl_unlink(), mei_release() calls kfree(cl).
If any remaining or deferred callback references the freed client, a
use-after-free occurs.

Fix this by flushing queues after unlinking the client from dev->file_list
inside mei_cl_unlink(), preventing concurrent IRQ completions from
populating the client's completed queue during teardown.

Reported-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
Cc: stable@vger.kernel.org
---
Thanks to Willy Tarreau and Greg Kroah-Hartman for their review and guidanc=
e
on the initial report.

Note: Sent via webmail; I have also attached the raw .patch file as a backu=
p
in case webmail clients introduce any subtle whitespace wrapping.

 drivers/misc/mei/client.c | 2 ++
 drivers/misc/mei/main.c   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 643b003..38b5792 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -695,6 +695,8 @@ int mei_cl_unlink(struct mei_cl *cl)
 =09cl->state =3D MEI_FILE_UNINITIALIZED;
 =09cl->writing_state =3D MEI_IDLE;
=20
+=09mei_cl_flush_queues(cl, NULL);
+
 =09WARN_ON(!list_empty(&cl->rd_completed) ||
 =09=09!list_empty(&cl->rd_pending) ||
 =09=09!list_empty(&cl->link));
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4fbf0b3..9e14ab4 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -148,7 +148,6 @@ static int mei_release(struct inode *inode, struct file=
 *file)
 =09=09goto out;
 =09}
=20
-=09mei_cl_flush_queues(cl, NULL);
 =09cl_dbg(dev, cl, "removing\n");
=20
 =09mei_cl_unlink(cl);
--=20
2.55.0
--b1=_6aGEWYnXA4YCd2X7XBB112FT7dVczYYh6hc0pQUw5g
Content-Type: text/x-patch; name=0001-misc-mei-fix-race-condition-between-client-teardown.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-misc-mei-fix-race-condition-between-client-teardown.patch

RnJvbSAwYzg2ZTk2Nzk5NmU0OWNmNjgxOGI2NDNlNDFkZmY2NjUwNGM3ZjA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaXJiaGF5IEt1bWFyIDxuaXJiaGF5eWt1bWFyckBwcm90b24u
bWU+CkRhdGU6IFN1biwgMjMgQXVnIDIwMjYgMTg6Mzc6NTMgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBtaXNjOiBtZWk6IGZpeCByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIGNsaWVudCB0ZWFyZG93biBh
bmQKIHJlYWQgY29tcGxldGlvbgoKSW4gbWVpX3JlbGVhc2UoKSwgYSBob3N0IGNsaWVudCBpcyB0
b3JuIGRvd24gdXBvbiBjbG9zZSgpLiBEdXJpbmcgdGhpcwp0ZWFyZG93biBzZXF1ZW5jZSwgbWVp
X2NsX2Rpc2Nvbm5lY3QoKSBpcyBpbnZva2VkLCB3aGljaCByZWxlYXNlcwpkZXYtPmRldmljZV9s
b2NrIHdoaWxlIHdhaXRpbmcgZm9yIHRoZSBmaXJtd2FyZSByZXNwb25zZS4KCklmIGFuIGluLWZs
aWdodCByZWFkIHJlcXVlc3Qgd2FzIHByZXZpb3VzbHkgc3VibWl0dGVkLCBhbiBpbmNvbWluZwpj
b21wbGV0aW9uIGludGVycnVwdCBwcm9jZXNzZWQgY29uY3VycmVudGx5IGJ5IHRoZSBNRUkgaW50
ZXJydXB0CmhhbmRsZXIgY2FuIGFkZCBhIGNvbXBsZXRlZCBjYWxsYmFjayBpbnRvIGNsLT5yZF9j
b21wbGV0ZWQgdmlhCm1laV9jbF9hZGRfcmRfY29tcGxldGVkKCkuCgpCZWNhdXNlIG1laV9jbF9m
bHVzaF9xdWV1ZXMoY2wsIE5VTEwpIHdhcyBpbnZva2VkIGJlZm9yZSBtZWlfY2xfdW5saW5rKGNs
KSwKYW4gaW5jb21pbmcgY29tcGxldGlvbiBjYWxsYmFjayBjYW4gc2xpcCBpbnRvIGNsLT5yZF9j
b21wbGV0ZWQgYWZ0ZXIgdGhlCmZsdXNoIGhhcyBjb21wbGV0ZWQgYnV0IGJlZm9yZSB0aGUgY2xp
ZW50IGlzIHVubGlua2VkIGZyb20gZGV2LT5maWxlX2xpc3QuCldoZW4gbWVpX2NsX3VubGluaygp
IGlzIHN1YnNlcXVlbnRseSBjYWxsZWQsIHRoZSBpbnZhcmlhbnQgY2hlY2sgYXQKZHJpdmVycy9t
aXNjL21laS9jbGllbnQuYzo2OTggdHJpZ2dlcnM6CgogIFdBUk5fT04oIWxpc3RfZW1wdHkoJmNs
LT5yZF9jb21wbGV0ZWQpIHx8CiAgICAgICAgICAhbGlzdF9lbXB0eSgmY2wtPnJkX3BlbmRpbmcp
IHx8CiAgICAgICAgICAhbGlzdF9lbXB0eSgmY2wtPmxpbmspKTsKCkNhbGwgdHJhY2U6CiAgV0FS
TklORzogQ1BVOiAyIFBJRDogNTA1NiBhdCBkcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jOjY5OCBt
ZWlfY2xfdW5saW5rKzB4YWEvMHgxNDAgW21laV0KICBSSVA6IDAwMTA6bWVpX2NsX3VubGluaysw
eGFhLzB4MTQwIFttZWldCiAgQ2FsbCBUcmFjZToKICAgPFRBU0s+CiAgIG1laV9yZWxlYXNlKzB4
MjAyLzB4MjcwIFttZWldCiAgIF9fZnB1dCsweDEwNS8weDJlMAogICBfX3g2NF9zeXNfY2xvc2Ur
MHg5MC8weDE0MAogICBkb19zeXNjYWxsXzY0KzB4YWEvMHg2NjAKICAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgogICA8L1RBU0s+CgpJbW1lZGlhdGVseSBmb2xsb3dp
bmcgbWVpX2NsX3VubGluaygpLCBtZWlfcmVsZWFzZSgpIGNhbGxzIGtmcmVlKGNsKS4KSWYgYW55
IHJlbWFpbmluZyBvciBkZWZlcnJlZCBjYWxsYmFjayByZWZlcmVuY2VzIHRoZSBmcmVlZCBjbGll
bnQsIGEKdXNlLWFmdGVyLWZyZWUgb2NjdXJzLgoKRml4IHRoaXMgYnkgZmx1c2hpbmcgcXVldWVz
IGFmdGVyIHVubGlua2luZyB0aGUgY2xpZW50IGZyb20gZGV2LT5maWxlX2xpc3QKaW5zaWRlIG1l
aV9jbF91bmxpbmsoKSwgcHJldmVudGluZyBjb25jdXJyZW50IElSUSBjb21wbGV0aW9ucyBmcm9t
CnBvcHVsYXRpbmcgdGhlIGNsaWVudCdzIGNvbXBsZXRlZCBxdWV1ZSBkdXJpbmcgdGVhcmRvd24u
CgpSZXBvcnRlZC1ieTogTmlyYmhheSBLdW1hciA8bmlyYmhheXlrdW1hcnJAcHJvdG9uLm1lPgpT
aWduZWQtb2ZmLWJ5OiBOaXJiaGF5IEt1bWFyIDxuaXJiaGF5eWt1bWFyckBwcm90b24ubWU+CkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnCi0tLQpUaGFua3MgdG8gV2lsbHkgVGFycmVhdSBhbmQg
R3JlZyBLcm9haC1IYXJ0bWFuIGZvciB0aGVpciByZXZpZXcgYW5kIGd1aWRhbmNlCm9uIHRoZSBp
bml0aWFsIHJlcG9ydC4KCk5vdGU6IFNlbnQgdmlhIHdlYm1haWw7IEkgaGF2ZSBhbHNvIGF0dGFj
aGVkIHRoZSByYXcgLnBhdGNoIGZpbGUgYXMgYSBiYWNrdXAKaW4gY2FzZSB3ZWJtYWlsIGNsaWVu
dHMgaW50cm9kdWNlIGFueSBzdWJ0bGUgd2hpdGVzcGFjZSB3cmFwcGluZy4KCiBkcml2ZXJzL21p
c2MvbWVpL2NsaWVudC5jIHwgMiArKwogZHJpdmVycy9taXNjL21laS9tYWluLmMgICB8IDEgLQog
MiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jIGIvZHJpdmVycy9taXNjL21laS9jbGllbnQu
YwppbmRleCA2NDNiMDAzLi4zOGI1NzkyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21pc2MvbWVpL2Ns
aWVudC5jCisrKyBiL2RyaXZlcnMvbWlzYy9tZWkvY2xpZW50LmMKQEAgLTY5NSw2ICs2OTUsOCBA
QCBpbnQgbWVpX2NsX3VubGluayhzdHJ1Y3QgbWVpX2NsICpjbCkKIAljbC0+c3RhdGUgPSBNRUlf
RklMRV9VTklOSVRJQUxJWkVEOwogCWNsLT53cml0aW5nX3N0YXRlID0gTUVJX0lETEU7CiAKKwlt
ZWlfY2xfZmx1c2hfcXVldWVzKGNsLCBOVUxMKTsKKwogCVdBUk5fT04oIWxpc3RfZW1wdHkoJmNs
LT5yZF9jb21wbGV0ZWQpIHx8CiAJCSFsaXN0X2VtcHR5KCZjbC0+cmRfcGVuZGluZykgfHwKIAkJ
IWxpc3RfZW1wdHkoJmNsLT5saW5rKSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL21h
aW4uYyBiL2RyaXZlcnMvbWlzYy9tZWkvbWFpbi5jCmluZGV4IDRmYmYwYjMuLjllMTRhYjQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvbWFpbi5jCisrKyBiL2RyaXZlcnMvbWlzYy9tZWkv
bWFpbi5jCkBAIC0xNDgsNyArMTQ4LDYgQEAgc3RhdGljIGludCBtZWlfcmVsZWFzZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAkJZ290byBvdXQ7CiAJfQogCi0JbWVp
X2NsX2ZsdXNoX3F1ZXVlcyhjbCwgTlVMTCk7CiAJY2xfZGJnKGRldiwgY2wsICJyZW1vdmluZ1xu
Iik7CiAKIAltZWlfY2xfdW5saW5rKGNsKTsKLS0gCjIuNTUuMA==

--b1=_6aGEWYnXA4YCd2X7XBB112FT7dVczYYh6hc0pQUw5g--

