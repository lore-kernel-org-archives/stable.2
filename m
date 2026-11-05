Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866253;
	b=ywZ2DbP/tcOASrf500zPcJzkMgCfFpuhRAAqwZSdcQS+jAwU7RSqgKg6A5QRoPbNbTa1
	 BILywR8wLZ5mde6UHqNWM8Gg0IB+qf1bdbVix1EYSO1N6/UfSRqZIaCETgHUJ/i0pvsIj
	 Xyvq94vXMt9JCUjmvJRbibcqtJ5P6sAEWBrEJxEpEfkfYhX70fHg0nd7aUKs1u3h9gk1W
	 QpCmPWPj1QVafiXmUTfIHJ4du2JzmsPyAsvKDRKlwDWauZ7jO77wTkVk4rGgnmLIVHcWd
	 Yn9nLXCIP00q9jglx0A7ownr/Eg8E7EL46ZYdNS7pxs5mAr4Ae3iOsiwlhE/LYiO0Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866253;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To;
	bh=KJX7XFKr2BJ3602v3cMnvakKbf4rDxLTSPpzuNkR+Ug=;
	b=K42ouMp9lAj9qNwVz/Je+292k/LomP+RTA0XUnXnMofFqY3vT9KYrl2/k7uO/cmX2CeN
	 F3ln7tTdVtsqk2Fht1NAzavytrYp2DXOiIZzu4V3BYpYVWssCcMVA630VzZID5ITzJ6CB
	 6XpxAv25QYxZ1Bo4fOGMVQLXYdHYKT1xGum20kMzRFzYh8WOWMP4uuNh8f334TDyAZN1U
	 hPFibbKiAOiiUXZ6s1QfFtNYmZM88eAMlnFP/KFhTMyjebjQpoJi+nrarf7j5kKryJ8Kv
	 qoXLAJ7LLNDI6iHK0SiOfWW8my97t6MF+J4aXbVOR6p1r8ET8OGz+kjW8LKcZl7aCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=fT1eCe5a;
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BA606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006BA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=fT1eCe5a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=KJX7XFKr2BJ3602v3cMnvakKbf4rDxLTSPpzuNkR+Ug=; b=fT1eCe5a/pOKfi6ETuLh64LIQk
	glSN6JwZJ5OqZMj3gPyRBlBpQr+pWkZ9A1jTMxZm6+cP1eV2pS4GK1E8rwFh4pyGt8QZbW1URir6K
	rHy7aWoxXnavxcbQhDxWJ8CHZ2m+QfJXAuPROvVcndnZVvFLyb5t3xnh49q1CartFX/dTv1/CCJua
	gxjQOr+3qiWCt5mIezcfWuPuv4XF68lvY18fxsCIwcPZPZGfqRCnAnHbSmioo4S9CEPCRVT19L3YP
	6YiHIQu0QYe/LClz4csCH2ONwRKurtx+psPS/Msete1D2je8LwikQJrbu3aW2CBBNb5zYQyRUm+Ww
	ThRYzbTwvBQSWbGm+rfvviHnKWTXFE9Pj0tT+mMx5zA6ywg0+ml/i4oWNuTRofbeeHMF/h3vqN0q0
	qCvSyOvizJkFhBhzhw9kXZi8VQCguHgNfWIrnjAa8dpiur+DiGm9blUetr7bt5WvgZtC96D5a9iU5
	htdAdtehaofbBW4EQXmSJ2P6;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOsYc-00000008UC0-3wLa;
	Thu, 05 Nov 2026 08:10:50 +0000
Content-Type: multipart/mixed; boundary="------------CTuvkRemNwwbaKVeToC3kgdX"
Message-ID: <5ff03aa9-eca4-41cc-9e1f-4ad8676bed6a@samba.org>
Date: Thu, 5 Nov 2026 09:10:50 +0100
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
 underflow in RDMA transfers" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org
Cc: stable@vger.kernel.org
References: <2026110438-macaw-walmart-26ac@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110438-macaw-walmart-26ac@gregkh>

This is a multi-part message in MIME format.
--------------CTuvkRemNwwbaKVeToC3kgdX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110438-macaw-walmart-26ac@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From 7193241a49c958782ba4b8df06da3734d1e317d2 Mon Sep 17 00:00:00 2001
> From: Stefan Metzmacher <metze@samba.org>
> Date: Fri, 23 Oct 2026 19:26:09 +0900
> Subject: [PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers
> 
> When a remote buffer descriptor is larger than the remaining local
> buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
> buf_len to zero. The common accounting code then subtracts the clamped
> length from buf_len, causing it to underflow. If another descriptor
> follows, the loop processes it with a wrapped remaining length and
> includes memory beyond the local buffer in the RDMA transfer.
> 
> A client can trigger an out-of-bounds kernel write with an SMB WRITE
> request, or an out-of-bounds kernel read with an SMB READ request, by
> supplying multiple RDMA buffer descriptors with an oversized descriptor
> before the last one.
> 
> Remove the premature assignment to buf_len. Subtracting the clamped length
> already consumes the remaining buffer, so the next iteration stops and
> only descriptors within the local buffer are used to build work requests.
> 
> Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
> Cc: stable@vger.kernel.org
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> 
> diff --git a/fs/smb/smbdirect/rw.c b/fs/smb/smbdirect/rw.c
> index 6fe38042cfb9..cb142c3c50b2 100644
> --- a/fs/smb/smbdirect/rw.c
> +++ b/fs/smb/smbdirect/rw.c
> @@ -143,7 +143,6 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
>   		if (desc_buf_len > buf_len) {
>   			desc_buf_len = buf_len;
>   			desc[i].length = cpu_to_le32(desc_buf_len);
> -			buf_len = 0;
>   		}
>   
>   		credits_needed += smbdirect_connection_calc_rw_credits(sc,

--------------CTuvkRemNwwbaKVeToC3kgdX
Content-Type: text/plain; charset=UTF-8;
 name="backport-6.1-smbdirect-rdma-xmit-underflow.txt"
Content-Disposition: attachment;
 filename="backport-6.1-smbdirect-rdma-xmit-underflow.txt"
Content-Transfer-Encoding: base64

RnJvbSBmNzJiNDZhY2MxYTgwNTJlMTc0MTgxNTUxZjNiNmU4NTNlZjI2NGEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEu
b3JnPgpEYXRlOiBGcmksIDIzIE9jdCAyMDI2IDE5OjI2OjA5ICswOTAwClN1YmplY3Q6IFtQ
QVRDSCA2LjEueV0gc21iOiBzbWJkaXJlY3Q6IGZpeCBidWZmZXIgbGVuZ3RoIHVuZGVyZmxv
dyBpbiBSRE1BCiB0cmFuc2ZlcnMKClsgVXBzdHJlYW0gY29tbWl0IDcxOTMyNDFhNDljOTU4
NzgyYmE0YjhkZjA2ZGEzNzM0ZDFlMzE3ZDIgXQoKV2hlbiBhIHJlbW90ZSBidWZmZXIgZGVz
Y3JpcHRvciBpcyBsYXJnZXIgdGhhbiB0aGUgcmVtYWluaW5nIGxvY2FsCmJ1ZmZlciwgc21i
ZGlyZWN0X2Nvbm5lY3Rpb25fcmRtYV94bWl0KCkgY2xhbXBzIGl0cyBsZW5ndGggYW5kIHNl
dHMKYnVmX2xlbiB0byB6ZXJvLiBUaGUgY29tbW9uIGFjY291bnRpbmcgY29kZSB0aGVuIHN1
YnRyYWN0cyB0aGUgY2xhbXBlZApsZW5ndGggZnJvbSBidWZfbGVuLCBjYXVzaW5nIGl0IHRv
IHVuZGVyZmxvdy4gSWYgYW5vdGhlciBkZXNjcmlwdG9yCmZvbGxvd3MsIHRoZSBsb29wIHBy
b2Nlc3NlcyBpdCB3aXRoIGEgd3JhcHBlZCByZW1haW5pbmcgbGVuZ3RoIGFuZAppbmNsdWRl
cyBtZW1vcnkgYmV5b25kIHRoZSBsb2NhbCBidWZmZXIgaW4gdGhlIFJETUEgdHJhbnNmZXIu
CgpBIGNsaWVudCBjYW4gdHJpZ2dlciBhbiBvdXQtb2YtYm91bmRzIGtlcm5lbCB3cml0ZSB3
aXRoIGFuIFNNQiBXUklURQpyZXF1ZXN0LCBvciBhbiBvdXQtb2YtYm91bmRzIGtlcm5lbCBy
ZWFkIHdpdGggYW4gU01CIFJFQUQgcmVxdWVzdCwgYnkKc3VwcGx5aW5nIG11bHRpcGxlIFJE
TUEgYnVmZmVyIGRlc2NyaXB0b3JzIHdpdGggYW4gb3ZlcnNpemVkIGRlc2NyaXB0b3IKYmVm
b3JlIHRoZSBsYXN0IG9uZS4KClJlbW92ZSB0aGUgcHJlbWF0dXJlIGFzc2lnbm1lbnQgdG8g
YnVmX2xlbi4gU3VidHJhY3RpbmcgdGhlIGNsYW1wZWQgbGVuZ3RoCmFscmVhZHkgY29uc3Vt
ZXMgdGhlIHJlbWFpbmluZyBidWZmZXIsIHNvIHRoZSBuZXh0IGl0ZXJhdGlvbiBzdG9wcyBh
bmQKb25seSBkZXNjcmlwdG9ycyB3aXRoaW4gdGhlIGxvY2FsIGJ1ZmZlciBhcmUgdXNlZCB0
byBidWlsZCB3b3JrIHJlcXVlc3RzLgoKRml4ZXM6IGU2MjhiZjkzOWFhZiAoImtzbWJkOiBy
ZWR1Y2UgZGVzY3JpcHRvciBzaXplIGlmIHJlbWFpbmluZyBieXRlcyBpcyBsZXNzIHRoYW4g
cmVxdWVzdCBzaXplIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKUmVwb3J0ZWQtYnk6
IHpkaS1kaXNjbG9zdXJlc0B0cmVuZG1pY3JvLmNvbSAjIFpESS1DQU4tMzM1NDkKU2lnbmVk
LW9mZi1ieTogU3RlZmFuIE1ldHptYWNoZXIgPG1ldHplQHNhbWJhLm9yZz4KU2lnbmVkLW9m
Zi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4KWyBtZXR6ZTogaW4g
Ni4xIHRoZSBjb2RlIGlzIHNtYl9kaXJlY3RfcmRtYV94bWl0KCkgaW4KICBmcy9zbWIvc2Vy
dmVyL3RyYW5zcG9ydF9yZG1hLmMgXQpBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVz
LTUtNQotLS0KIGZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3JkbWEuYyB8IDEgLQogMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL3Ry
YW5zcG9ydF9yZG1hLmMgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMKaW5kZXgg
YmNmMDYzMWNlMTBhLi5jYzk0MDliYjU0MDQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9zZXJ2ZXIv
dHJhbnNwb3J0X3JkbWEuYworKysgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMK
QEAgLTEzNzgsNyArMTM3OCw2IEBAIHN0YXRpYyBpbnQgc21iX2RpcmVjdF9yZG1hX3htaXQo
c3RydWN0IHNtYl9kaXJlY3RfdHJhbnNwb3J0ICp0LAogCQlpZiAoZGVzY19idWZfbGVuID4g
YnVmX2xlbikgewogCQkJZGVzY19idWZfbGVuID0gYnVmX2xlbjsKIAkJCWRlc2NbaV0ubGVu
Z3RoID0gY3B1X3RvX2xlMzIoZGVzY19idWZfbGVuKTsKLQkJCWJ1Zl9sZW4gPSAwOwogCQl9
CiAKIAkJY3JlZGl0c19uZWVkZWQgKz0gY2FsY19yd19jcmVkaXRzKHQsIGRlc2NfYnVmLCBk
ZXNjX2J1Zl9sZW4pOwotLSAKMi41My4wCgo=

--------------CTuvkRemNwwbaKVeToC3kgdX--
