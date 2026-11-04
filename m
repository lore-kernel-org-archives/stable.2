Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823916;
	b=jaPedXrHxowyJCk+mBwCokUmbLV/Q13gdJOA/SnJKrGYePZMktneNZeGtznqRGTbCca6
	 YRfJqEEVInTreQ7HEeqKDvXxB75zpz2QumhRRtF5Uik9wWWbYo8nu5M2HpdSbF4ewM0J6
	 LUCf0SjS3MCCy+FkQgHtfV4HGkHEYStRLY1cPDtDunnSEJSlq1Fzz1NRnsJEu08BBYl5s
	 dUvv/9zm3q/LvSwKeqSVsnMESsPOVuOAlIiLVfjZze+0QubYyySJY/f/dxFE+wmQkoDXY
	 /ORw54wz5zNAMshjkytEfSe+BoyvHZFCoxt+ip8ac7lSg2sGEryVmmoczr4EbyfjsSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823916;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To;
	bh=TZABtKadUFasFSU5sqIAkf+uqudo/GtONLBq0fkRlkI=;
	b=Qp4bbVdUCl66vjuhH6v7iwRyNhQKWIonaG+PgCs6OGTBCu83vznWiewcOReWyPNCd2gN
	 mX3P7TL5mYib1dm9tci1urJHBzxwsZDhcmqhVUl0LKXz+HtJ4KudnKFZW4Qf+RLw3Cp4U
	 gGr2n+yWkZ/mT4DULhd/akX+Ay46onOvoHBrhvyeCMAk/r93pn7Y9ZHV0Ob8L7doO0jI8
	 fvJlUH3I+RxmelWVoPvMD0pu/Lvz5nGfaLd5enYaMWT9ANCRT4OqLhBfv/K+MGceqrgyb
	 SoHqAMu02FUaVgDF06glISS1uqfOe5TBPnw3QxPSbE5dgHqcj5H2SH5dlb0JjyMxCTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=FQuL6MWF;
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812B606A33B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3812B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=FQuL6MWF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=TZABtKadUFasFSU5sqIAkf+uqudo/GtONLBq0fkRlkI=; b=FQuL6MWFvUqTZSUlnxGkogmeJD
	968HGixCGV2tp7TREioHd5k0FvHvKrhfmqI064xkuyW/lkPGECRLQMY3qgxms/MMgVo0QL3ll4RlU
	ep86sxQ2//zewb8sMbSVA4abKlU8SSXwrDAkY1u19zQYo4e5ZjHAXVLVsCxBecDubiMa5wheaPLLf
	KE+3cfqzB7A5sYv2uEdHKgU1uf8L+VCdasNYfM3Arns7IJ3i/t8ZP3sON80wCDHattf/m8LK8fNTu
	UjyuTkydSLc6QYdJyaTLlWsu0rf2HDRIHCGQf9GkVj6cP8ru0OYTHCEuXWCl2nItoCz3U4xvjVWOi
	yEZ0YyLNKP93AFHDMZ1OPBIKmO1ibFnl+oDZfwimTbmpjjUE3shi0WarhXGux5NwiB0mtrTIHO1mF
	p5IctJbNVeQ9yF84Gr6596CMeBNleNJRD/NmDmmfNuWq+SfO5Y7SdFT9V7iKH42nL26+U0f43lBm0
	VxGVu6LSb2OfsEsoWyclMVj6;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOhXk-00000008K9N-1jtt;
	Wed, 04 Nov 2026 20:25:12 +0000
Content-Type: multipart/mixed; boundary="------------x0e0LQuA5f0PSEnywj6AxKgh"
Message-ID: <aa2bf49f-cdf0-4b7f-a798-0ea6ccdc4b3f@samba.org>
Date: Wed, 4 Nov 2026 21:25:11 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length
 underflow in RDMA transfers" failed to apply to 6.18-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linkinjeon@kernel.org, stable@vger.kernel.org
References: <2026110436-thee-asleep-2059@gregkh>
 <456026fe-5cf5-4a35-bf82-75d5ed652846@samba.org>
 <2026110423-sediment-landing-8a9d@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110423-sediment-landing-8a9d@gregkh>

This is a multi-part message in MIME format.
--------------x0e0LQuA5f0PSEnywj6AxKgh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 20:24 schrieb Greg KH:
> On Wed, Nov 04, 2026 at 08:12:22PM +0100, Stefan Metzmacher wrote:
>> Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
>>>
>>> The patch below does not apply to the 6.18-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110436-thee-asleep-2059@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
>>>
>>> Possible dependencies:
>>>
>>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>> ------------------ original commit in Linus's tree ------------------
>>>
>>>   From 7193241a49c958782ba4b8df06da3734d1e317d2 Mon Sep 17 00:00:00 2001
>>> From: Stefan Metzmacher <metze@samba.org>
>>> Date: Fri, 23 Oct 2026 19:26:09 +0900
>>> Subject: [PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers
>>>
>>> When a remote buffer descriptor is larger than the remaining local
>>> buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
>>> buf_len to zero. The common accounting code then subtracts the clamped
>>> length from buf_len, causing it to underflow. If another descriptor
>>> follows, the loop processes it with a wrapped remaining length and
>>> includes memory beyond the local buffer in the RDMA transfer.
>>>
>>> A client can trigger an out-of-bounds kernel write with an SMB WRITE
>>> request, or an out-of-bounds kernel read with an SMB READ request, by
>>> supplying multiple RDMA buffer descriptors with an oversized descriptor
>>> before the last one.
>>>
>>> Remove the premature assignment to buf_len. Subtracting the clamped length
>>> already consumes the remaining buffer, so the next iteration stops and
>>> only descriptors within the local buffer are used to build work requests.
>>>
>>> Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
>>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>>>
>>> diff --git a/fs/smb/smbdirect/rw.c b/fs/smb/smbdirect/rw.c
>>> index 6fe38042cfb9..cb142c3c50b2 100644
>>> --- a/fs/smb/smbdirect/rw.c
>>> +++ b/fs/smb/smbdirect/rw.c
>>> @@ -143,7 +143,6 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
>>>    		if (desc_buf_len > buf_len) {
>>>    			desc_buf_len = buf_len;
>>>    			desc[i].length = cpu_to_le32(desc_buf_len);
>>> -			buf_len = 0;
>>>    		}
>>>    		credits_needed += smbdirect_connection_calc_rw_credits(sc,
>>
>> In older releases this is smb_direct_rdma_xmit() in fs/smb/server/transport_rdma.c
>>
>> I hope that helps.
> 
> A backported patch would help best :)

Try this :-)

--------------x0e0LQuA5f0PSEnywj6AxKgh
Content-Type: text/plain; charset=UTF-8;
 name="backport-6.18-smbdirect-rdma-xmit-underflow.txt"
Content-Disposition: attachment;
 filename="backport-6.18-smbdirect-rdma-xmit-underflow.txt"
Content-Transfer-Encoding: base64

RnJvbSA2ZjcwYmExMjE2YWI0NDQ0MGEzYWZlZGFjMjBhZjBmYTU3NDliZDgwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEu
b3JnPgpEYXRlOiBGcmksIDIzIE9jdCAyMDI2IDE5OjI2OjA5ICswOTAwClN1YmplY3Q6IFtQ
QVRDSF0gc21iOiBzbWJkaXJlY3Q6IGZpeCBidWZmZXIgbGVuZ3RoIHVuZGVyZmxvdyBpbiBS
RE1BIHRyYW5zZmVycwoKWyBVcHN0cmVhbSBjb21taXQgNzE5MzI0MWE0OWM5NTg3ODJiYTRi
OGRmMDZkYTM3MzRkMWUzMTdkMiBdCgpXaGVuIGEgcmVtb3RlIGJ1ZmZlciBkZXNjcmlwdG9y
IGlzIGxhcmdlciB0aGFuIHRoZSByZW1haW5pbmcgbG9jYWwKYnVmZmVyLCBzbWJkaXJlY3Rf
Y29ubmVjdGlvbl9yZG1hX3htaXQoKSBjbGFtcHMgaXRzIGxlbmd0aCBhbmQgc2V0cwpidWZf
bGVuIHRvIHplcm8uIFRoZSBjb21tb24gYWNjb3VudGluZyBjb2RlIHRoZW4gc3VidHJhY3Rz
IHRoZSBjbGFtcGVkCmxlbmd0aCBmcm9tIGJ1Zl9sZW4sIGNhdXNpbmcgaXQgdG8gdW5kZXJm
bG93LiBJZiBhbm90aGVyIGRlc2NyaXB0b3IKZm9sbG93cywgdGhlIGxvb3AgcHJvY2Vzc2Vz
IGl0IHdpdGggYSB3cmFwcGVkIHJlbWFpbmluZyBsZW5ndGggYW5kCmluY2x1ZGVzIG1lbW9y
eSBiZXlvbmQgdGhlIGxvY2FsIGJ1ZmZlciBpbiB0aGUgUkRNQSB0cmFuc2Zlci4KCkEgY2xp
ZW50IGNhbiB0cmlnZ2VyIGFuIG91dC1vZi1ib3VuZHMga2VybmVsIHdyaXRlIHdpdGggYW4g
U01CIFdSSVRFCnJlcXVlc3QsIG9yIGFuIG91dC1vZi1ib3VuZHMga2VybmVsIHJlYWQgd2l0
aCBhbiBTTUIgUkVBRCByZXF1ZXN0LCBieQpzdXBwbHlpbmcgbXVsdGlwbGUgUkRNQSBidWZm
ZXIgZGVzY3JpcHRvcnMgd2l0aCBhbiBvdmVyc2l6ZWQgZGVzY3JpcHRvcgpiZWZvcmUgdGhl
IGxhc3Qgb25lLgoKUmVtb3ZlIHRoZSBwcmVtYXR1cmUgYXNzaWdubWVudCB0byBidWZfbGVu
LiBTdWJ0cmFjdGluZyB0aGUgY2xhbXBlZCBsZW5ndGgKYWxyZWFkeSBjb25zdW1lcyB0aGUg
cmVtYWluaW5nIGJ1ZmZlciwgc28gdGhlIG5leHQgaXRlcmF0aW9uIHN0b3BzIGFuZApvbmx5
IGRlc2NyaXB0b3JzIHdpdGhpbiB0aGUgbG9jYWwgYnVmZmVyIGFyZSB1c2VkIHRvIGJ1aWxk
IHdvcmsgcmVxdWVzdHMuCgpGaXhlczogZTYyOGJmOTM5YWFmICgia3NtYmQ6IHJlZHVjZSBk
ZXNjcmlwdG9yIHNpemUgaWYgcmVtYWluaW5nIGJ5dGVzIGlzIGxlc3MgdGhhbiByZXF1ZXN0
IHNpemUiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpSZXBvcnRlZC1ieTogemRpLWRp
c2Nsb3N1cmVzQHRyZW5kbWljcm8uY29tICMgWkRJLUNBTi0zMzU0OQpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPgpTaWduZWQtb2ZmLWJ5OiBO
YW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpbIG1ldHplOiBpbiA2LjE4IHRo
ZSBjb2RlIGlzIHNtYl9kaXJlY3RfcmRtYV94bWl0KCkgaW4KICBmcy9zbWIvc2VydmVyL3Ry
YW5zcG9ydF9yZG1hLmMgXQpBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUtNQot
LS0KIGZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3JkbWEuYyB8IDEgLQogMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL3RyYW5zcG9y
dF9yZG1hLmMgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMKaW5kZXggM2Y5YmNk
MTBhMGIzLi5mZWQwYzdkYjIyNGYgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNw
b3J0X3JkbWEuYworKysgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMKQEAgLTE3
MjQsNyArMTcyNCw2IEBAIHN0YXRpYyBpbnQgc21iX2RpcmVjdF9yZG1hX3htaXQoc3RydWN0
IHNtYl9kaXJlY3RfdHJhbnNwb3J0ICp0LAogCQlpZiAoZGVzY19idWZfbGVuID4gYnVmX2xl
bikgewogCQkJZGVzY19idWZfbGVuID0gYnVmX2xlbjsKIAkJCWRlc2NbaV0ubGVuZ3RoID0g
Y3B1X3RvX2xlMzIoZGVzY19idWZfbGVuKTsKLQkJCWJ1Zl9sZW4gPSAwOwogCQl9CiAKIAkJ
Y3JlZGl0c19uZWVkZWQgKz0gY2FsY19yd19jcmVkaXRzKHNjLCBkZXNjX2J1ZiwgZGVzY19i
dWZfbGVuKTsKLS0gCjIuNDMuMAoK

--------------x0e0LQuA5f0PSEnywj6AxKgh--
