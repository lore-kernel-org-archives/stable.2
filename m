Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866274;
	b=ErbfyVon6rPl0r7etYjpDZSIsaweifYPYzc5HGlPtBQ7W/tev/RBdYkVZIb8fPPUOfEv
	 wyLOsF8P+DoDQKxfRrcjteR0gh/aF7D9PpGdjWM/d4Wnpitcf0UO1Zh+teXqlEb63rWhF
	 nMUpaKw/kgkdeCSmrgImDGHjxZUgpi3qNdzj6Vo8wYlRDLmIdnyA5sr6etLGMmHEsEtFp
	 rFJB3BCwubhWu/otOKyNSJYR3tQ75L59O0ajt3bpYaUkYNCnGHuPHBpbsj5VuVwnZiTK+
	 D0VXXlGW0/1g2dozo/Nu7OUanBI8I2S4hrL7Eec75byvE6dvVu2DbBWrvla2uPYOBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866274;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To;
	bh=asmqg6/1UGnzh4bWkxJ0A6ElYaEK2fDZylXj6jVvh0E=;
	b=wAUdGB3tpOW3M5UNTqG65t+nHGbbQY2bh6Oq8aH6g97EQisHqRzs50S5JEPnGWOa9JSw
	 SFmHUZrU/zWl82Et9RmpGrTrScBm/8Es9HL3BD13DKUIEk7jgWPTNUd5eyIo7/EOxL8oF
	 f9azFuQmQCOoMuG3E3pegHSJshDuAPuF/kjCaRCHDrz6F8yrPDB0dgjH9phSrGqzldG8Q
	 IjMt/nbr6/JbiH2XC88nXZUNX6dUrtPUYYZ1nkcpMX1cgz4YYErIbghgFTRHQy8IS3fVY
	 wYTUhtqrdXvcqatbrt1t3vITPFK+7rN9mp5V8OdTvAv2IDeZBXvPtSfyi1lKic8tHzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=Kyrq8wIt;
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1E606A335
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD1E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=Kyrq8wIt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=asmqg6/1UGnzh4bWkxJ0A6ElYaEK2fDZylXj6jVvh0E=; b=Kyrq8wIt0qLzdnxGGtS6MRDNEI
	f1CpolBv4SEWvLafSR6a1ws22wGG/RA8dYryg0NY7Z9wjxOP/w4HbU4kOAcUQGFKahIfkPDH3aEsy
	zJJ2DqL5TfNsiFG5/7I82fojYeZq/zwGY5rfePq5+mGJ8TODaUxmV7fWD8ivo93emWFuAS0UMaH3W
	wOwmG/obbQ3cnZaNuSDhVnxKoVifc/ufTMDqG7i2fhGG9aT3vsF2P2+X50ixkc20bwxTEHcYPLCN/
	yF3ZaoZgJwKuytBUkTMQkAadU7gp+CibqSAUqm1xu+N+af431dJYvJfPNn0foPoyYrYyhS6CA00zj
	xHjreUXILBXw3xZ9l0BdAimtNXVgsGaUg83s45cf8Qp2cfcZcITHddld+mSZ+M8MO5BEL9LFdLAvC
	pOp72+wC2rRWaYVvBqyCRZFShjGzqQx6wNNuytWl1CoTiXg1GByEVkBbhStTn8/ad7+3vf854aBhI
	l/uziYgxOGUnwtkYiHhiB5zH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOsYx-00000008UCM-3Qtk;
	Thu, 05 Nov 2026 08:11:11 +0000
Content-Type: multipart/mixed; boundary="------------jeUjgU0wX0mpfHou0YXCjYtl"
Message-ID: <71706f92-565e-4179-8a05-b5ae218d9397@samba.org>
Date: Thu, 5 Nov 2026 09:11:11 +0100
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
 underflow in RDMA transfers" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org
Cc: stable@vger.kernel.org
References: <2026110439-qualify-confiding-f593@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110439-qualify-confiding-f593@gregkh>

This is a multi-part message in MIME format.
--------------jeUjgU0wX0mpfHou0YXCjYtl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-qualify-confiding-f593@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'
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

--------------jeUjgU0wX0mpfHou0YXCjYtl
Content-Type: text/plain; charset=UTF-8;
 name="backport-5.15-smbdirect-rdma-xmit-underflow.txt"
Content-Disposition: attachment;
 filename="backport-5.15-smbdirect-rdma-xmit-underflow.txt"
Content-Transfer-Encoding: base64

RnJvbSBmN2VhMmI2ODJmYmZkNTNhMTA3MDc4YmQwMDlhMGVlNjgxOGIyZGMxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEu
b3JnPgpEYXRlOiBGcmksIDIzIE9jdCAyMDI2IDE5OjI2OjA5ICswOTAwClN1YmplY3Q6IFtQ
QVRDSCA1LjE1LnldIHNtYjogc21iZGlyZWN0OiBmaXggYnVmZmVyIGxlbmd0aCB1bmRlcmZs
b3cgaW4gUkRNQQogdHJhbnNmZXJzCgpbIFVwc3RyZWFtIGNvbW1pdCA3MTkzMjQxYTQ5Yzk1
ODc4MmJhNGI4ZGYwNmRhMzczNGQxZTMxN2QyIF0KCldoZW4gYSByZW1vdGUgYnVmZmVyIGRl
c2NyaXB0b3IgaXMgbGFyZ2VyIHRoYW4gdGhlIHJlbWFpbmluZyBsb2NhbApidWZmZXIsIHNt
YmRpcmVjdF9jb25uZWN0aW9uX3JkbWFfeG1pdCgpIGNsYW1wcyBpdHMgbGVuZ3RoIGFuZCBz
ZXRzCmJ1Zl9sZW4gdG8gemVyby4gVGhlIGNvbW1vbiBhY2NvdW50aW5nIGNvZGUgdGhlbiBz
dWJ0cmFjdHMgdGhlIGNsYW1wZWQKbGVuZ3RoIGZyb20gYnVmX2xlbiwgY2F1c2luZyBpdCB0
byB1bmRlcmZsb3cuIElmIGFub3RoZXIgZGVzY3JpcHRvcgpmb2xsb3dzLCB0aGUgbG9vcCBw
cm9jZXNzZXMgaXQgd2l0aCBhIHdyYXBwZWQgcmVtYWluaW5nIGxlbmd0aCBhbmQKaW5jbHVk
ZXMgbWVtb3J5IGJleW9uZCB0aGUgbG9jYWwgYnVmZmVyIGluIHRoZSBSRE1BIHRyYW5zZmVy
LgoKQSBjbGllbnQgY2FuIHRyaWdnZXIgYW4gb3V0LW9mLWJvdW5kcyBrZXJuZWwgd3JpdGUg
d2l0aCBhbiBTTUIgV1JJVEUKcmVxdWVzdCwgb3IgYW4gb3V0LW9mLWJvdW5kcyBrZXJuZWwg
cmVhZCB3aXRoIGFuIFNNQiBSRUFEIHJlcXVlc3QsIGJ5CnN1cHBseWluZyBtdWx0aXBsZSBS
RE1BIGJ1ZmZlciBkZXNjcmlwdG9ycyB3aXRoIGFuIG92ZXJzaXplZCBkZXNjcmlwdG9yCmJl
Zm9yZSB0aGUgbGFzdCBvbmUuCgpSZW1vdmUgdGhlIHByZW1hdHVyZSBhc3NpZ25tZW50IHRv
IGJ1Zl9sZW4uIFN1YnRyYWN0aW5nIHRoZSBjbGFtcGVkIGxlbmd0aAphbHJlYWR5IGNvbnN1
bWVzIHRoZSByZW1haW5pbmcgYnVmZmVyLCBzbyB0aGUgbmV4dCBpdGVyYXRpb24gc3RvcHMg
YW5kCm9ubHkgZGVzY3JpcHRvcnMgd2l0aGluIHRoZSBsb2NhbCBidWZmZXIgYXJlIHVzZWQg
dG8gYnVpbGQgd29yayByZXF1ZXN0cy4KCkZpeGVzOiBlNjI4YmY5MzlhYWYgKCJrc21iZDog
cmVkdWNlIGRlc2NyaXB0b3Igc2l6ZSBpZiByZW1haW5pbmcgYnl0ZXMgaXMgbGVzcyB0aGFu
IHJlcXVlc3Qgc2l6ZSIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5
OiB6ZGktZGlzY2xvc3VyZXNAdHJlbmRtaWNyby5jb20gIyBaREktQ0FOLTMzNTQ5ClNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbiBNZXR6bWFjaGVyIDxtZXR6ZUBzYW1iYS5vcmc+ClNpZ25lZC1v
ZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+ClsgbWV0emU6IGlu
IDUuMTUgdGhlIGNvZGUgaXMgc21iX2RpcmVjdF9yZG1hX3htaXQoKSBpbgogIGZzL2tzbWJk
L3RyYW5zcG9ydF9yZG1hLmMgXQpBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUt
NQotLS0KIGZzL2tzbWJkL3RyYW5zcG9ydF9yZG1hLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMva3NtYmQvdHJhbnNwb3J0X3JkbWEu
YyBiL2ZzL2tzbWJkL3RyYW5zcG9ydF9yZG1hLmMKaW5kZXggNmVhNzNmZTZkZTZjLi45OTg2
ZTE5MWU3MDEgMTAwNjQ0Ci0tLSBhL2ZzL2tzbWJkL3RyYW5zcG9ydF9yZG1hLmMKKysrIGIv
ZnMva3NtYmQvdHJhbnNwb3J0X3JkbWEuYwpAQCAtMTM2MSw3ICsxMzYxLDYgQEAgc3RhdGlj
IGludCBzbWJfZGlyZWN0X3JkbWFfeG1pdChzdHJ1Y3Qgc21iX2RpcmVjdF90cmFuc3BvcnQg
KnQsCiAJCWlmIChkZXNjX2J1Zl9sZW4gPiBidWZfbGVuKSB7CiAJCQlkZXNjX2J1Zl9sZW4g
PSBidWZfbGVuOwogCQkJZGVzY1tpXS5sZW5ndGggPSBjcHVfdG9fbGUzMihkZXNjX2J1Zl9s
ZW4pOwotCQkJYnVmX2xlbiA9IDA7CiAJCX0KIAogCQljcmVkaXRzX25lZWRlZCArPSBjYWxj
X3J3X2NyZWRpdHModCwgZGVzY19idWYsIGRlc2NfYnVmX2xlbik7Ci0tIAoyLjUzLjAKCg==


--------------jeUjgU0wX0mpfHou0YXCjYtl--
