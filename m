Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866219;
	b=CCyTueKvdt6PEEeE28E0+mvRSFSaduEtGG7UYxg2AEp4yUEA2aqAgV9X95wXURwoob+c
	 2e2AtBmzjAtXiTP/dUcqKaTnv3NhuHrBLgm1D2k0jPCyKGw90h3UeKfzFqo5/54UtvE6P
	 RtsuIvRMCDEfEblHi23uy0iExcwrgpmN5I4V2FgEX9Pq6eudVC6+OZe8ZiH77vqjzjWxz
	 2FjmCOu8KsdqYQ8CDuLJQxklZKkjVf3jKKxu2KQMXbn/vEcmf8MzicQrw6TsTyfplwk02
	 0x3U1mJYQgJyhQcg2ab3QDad3tXOzvM+wZjZn1EP9YKPh+zJW8AZusp1JP1aoocGzoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866219;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To;
	bh=LKtUYXUIDFpML0kPQsPssvtpKcDDfoa2YZs3nvL2GQk=;
	b=Pwue8UNxdJkAwx1tsQNbJClQ9Mif2riv65XW3dxYFp1kJC0FRvxV1ubS9UQpiFZ4ypXg
	 CaWCov7/nMJgS79BtvXcb3BtgOagji1gJIHtXZ61ZX9amP2GH0U2z2y1H61nzFf6ga2gD
	 scYhEtDeO4G7gVB50uBbknZxX8+k4luKeUnhGuAB92r7zrzDjYDzcbLdAA0AaP+gTR86k
	 zZksoPqtafRmrcqrbQ3B9bDLVonXEyhg1SdR6MaDbHcCGCIhSgIp/kMjBKqVpLLXAQrPV
	 7dONqiN+iV3Li5yIS7MbFWDAJGHE4RhT2DkAT+biqTVdp8DHfCFYnyl5Sq5DMwWX79g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=DztBhM9+;
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A78606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A78606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=DztBhM9+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=LKtUYXUIDFpML0kPQsPssvtpKcDDfoa2YZs3nvL2GQk=; b=DztBhM9+DXr4r+Q6mCsGXCDi3P
	Dgzwgsz68yxKDbf0Y8YFFqsNri30zWwMo72DH16Qo1OqcqxLwkvJejl6IJvlYJO3cvP8SPzI1hytE
	bUFCasbTuiK9SkqrxcqwyXqUGEsZCd8wxNF/anq7Fi4BUXBvra/HBu4u6HvdMrJccTm81wEMDtL7W
	AvcVypGT5uv641rBsEN/aOoZE7aKFRK5P18nLRplJbQY4jR3/69U0zOxyu7ccQkmLeTAXhcvAy0gG
	H4ocliGzCekSO8ibr/7S9k+jpMbLMs4w5BBlSWVOnYYFlLN00aW0OvQQqlBmrjtqpByFxmktkrlkr
	/MLz6VwjLAeYuj2T4OwoQIWDEKJSID2zvvZzEzO4wr8IIavaO3uVZAiLlAX8yotPa5txcBhKTphe7
	F8SmBG9Qs0T4pxrndff+C5D8UuRmV1IvMqF4qoTePD7BOV8HQgEId4oKNfiP6xfif952AFBMcwdkC
	SExpDJ2jvbm0/GsIL6ruVySe;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOsY3-00000008UB4-3uHg;
	Thu, 05 Nov 2026 08:10:16 +0000
Content-Type: multipart/mixed; boundary="------------IEtIK1YxxNdIYu3HvIUjP0On"
Message-ID: <751f0e5b-c37d-47a4-a45d-56043ccbb8d2@samba.org>
Date: Thu, 5 Nov 2026 09:10:15 +0100
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
 underflow in RDMA transfers" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org
Cc: stable@vger.kernel.org
References: <2026110437-flagpole-glitch-eff0@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110437-flagpole-glitch-eff0@gregkh>

This is a multi-part message in MIME format.
--------------IEtIK1YxxNdIYu3HvIUjP0On
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-flagpole-glitch-eff0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'
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

--------------IEtIK1YxxNdIYu3HvIUjP0On
Content-Type: text/plain; charset=UTF-8;
 name="backport-6.6-smbdirect-rdma-xmit-underflow.txt"
Content-Disposition: attachment;
 filename="backport-6.6-smbdirect-rdma-xmit-underflow.txt"
Content-Transfer-Encoding: base64

RnJvbSAxNmY5MzU4MTBmYzY1NTNkMmNhZmY0YmQ3NDBlMjFlM2RjMGFlNDBhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEu
b3JnPgpEYXRlOiBGcmksIDIzIE9jdCAyMDI2IDE5OjI2OjA5ICswOTAwClN1YmplY3Q6IFtQ
QVRDSCA2LjYueV0gc21iOiBzbWJkaXJlY3Q6IGZpeCBidWZmZXIgbGVuZ3RoIHVuZGVyZmxv
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
Ni42IHRoZSBjb2RlIGlzIHNtYl9kaXJlY3RfcmRtYV94bWl0KCkgaW4KICBmcy9zbWIvc2Vy
dmVyL3RyYW5zcG9ydF9yZG1hLmMgXQpBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVz
LTUtNQotLS0KIGZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3JkbWEuYyB8IDEgLQogMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL3Ry
YW5zcG9ydF9yZG1hLmMgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMKaW5kZXgg
ZDUyMmFjZTIwODQwLi42MGMwM2U1OTBiYTkgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9zZXJ2ZXIv
dHJhbnNwb3J0X3JkbWEuYworKysgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9yZG1hLmMK
QEAgLTEzODgsNyArMTM4OCw2IEBAIHN0YXRpYyBpbnQgc21iX2RpcmVjdF9yZG1hX3htaXQo
c3RydWN0IHNtYl9kaXJlY3RfdHJhbnNwb3J0ICp0LAogCQlpZiAoZGVzY19idWZfbGVuID4g
YnVmX2xlbikgewogCQkJZGVzY19idWZfbGVuID0gYnVmX2xlbjsKIAkJCWRlc2NbaV0ubGVu
Z3RoID0gY3B1X3RvX2xlMzIoZGVzY19idWZfbGVuKTsKLQkJCWJ1Zl9sZW4gPSAwOwogCQl9
CiAKIAkJY3JlZGl0c19uZWVkZWQgKz0gY2FsY19yd19jcmVkaXRzKHQsIGRlc2NfYnVmLCBk
ZXNjX2J1Zl9sZW4pOwotLSAKMi41My4wCgo=

--------------IEtIK1YxxNdIYu3HvIUjP0On--
