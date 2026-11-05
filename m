Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866200;
	b=jNlYbuz7vIUf+Ptlf+uJkOjAR5zmTpN6KuZVy5LWR4+4u5kI6AImWTNQyqAz+TeCh2tf
	 IfD5PKy+QekzEmIS4J8milLfdenl/CoW4x0zk27uWhmC+fHluxHhG/6gy59VAg17ua6+F
	 bY9Uei3thOgO9W2IK2QhgbCGeNzqY8jii1/hx1jdQiQiWqGe5J+xSJg2rguTM/FDCb7r7
	 T13wM4ebBib1iRiVk0fF2AoUF93LZlzXCG0cLJvKVaK0iSz6zOmu+sR2q6tCxAJx2CHam
	 RMNc6XrNGOA8/GBxS4M2yQX6XKEDRLj3d5TfQG+uc96hMNzo4eYxlTJMpUZ8R0hNryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866200;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To;
	bh=PypcCrxWtX8Czq3M6HsMe6nDxbxrgdP6dZiEaRUwvCc=;
	b=qBrdeu5QgQgJ+BM8puNpCcfnO1iQN1UB2YfUoMBhWyBWPqt45zCsoY2J+rJGoQ4TIrx4
	 xV24W+02CLapyPKhyU5v0yTMbNjZuRZe+4RmzVJrmkvZ/vD9cRLxTghYPoSXucL8jX0NM
	 0ALbcgjqM9Oih7or7B63/G8MqSe2oA8+OU13RjoCHhAG1ihEbzrmTu2Q5N1mx/4PIp3pq
	 MxiyP24yL9RAW23zcJGFo1FsKwlB3f6OS1VYbu6FpofE8Pw+hgV56wo+Ugl/RJhW2DcBL
	 ZR5RUITDr6XwnwcMOfeUf5wYYDbUe6sbR5nLIzb4vh0j9k0GfIdw5cRRxloUQ6pPTSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b="N/ba8gKc";
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0F606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B0F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=N/ba8gKc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=PypcCrxWtX8Czq3M6HsMe6nDxbxrgdP6dZiEaRUwvCc=; b=N/ba8gKckrwkUZXfwMZHQkr8Gr
	j/NA1BEy5MKmxxQZApv91lHktc0AxlJHKfONubed5mkCgKSuOawkovW5gVeZDgGs7/4Bw4jJpxo1P
	7MCry8Iv2emq9W/TLD0Jq+km4LuLWA0E8n6yzC+ZXLzJNk/3AO57SRPHdsr+7MO+2oB9corjL9b8Q
	5b7qPpvrJW7rjkcwLdh0IYg29IpRCZE1GaEoXg8cK3RzAUc6Yp9a7ZJzquyLuDHETFAfSwfTjyvFf
	6yEeKobMu/DtubPj0yHhHUvvdDXlzK5oqzqi67BLHvObIzHpQqvuHEErcgc85VBheBtXV5PCVS7hA
	FQruO9mxALY1ts6oBWGaJ04DF2iocoLik9BUXAUeIFoDfIWmnmwEeVbqZoMFHqfZWMPrrGrOqGZPF
	BxvOdO10ikuECTIyGMwwxKAfJPYEkU8/7Ab/2o4geJ9xGDNlJbDcDIqZzgtwtDi53ra8ouyTLWkTs
	/u7JAK0XVn4lRVoXWg+cJfEd;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOsXk-00000008UAN-2wjl;
	Thu, 05 Nov 2026 08:09:56 +0000
Content-Type: multipart/mixed; boundary="------------37M9895EDf3m31e3Dk48gJfv"
Message-ID: <1cc78f27-f1d8-48aa-861f-1f8a3f84b9b3@samba.org>
Date: Thu, 5 Nov 2026 09:09:55 +0100
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
 underflow in RDMA transfers" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org
Cc: stable@vger.kernel.org
References: <2026110437-bully-enviable-15b3@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110437-bully-enviable-15b3@gregkh>

This is a multi-part message in MIME format.
--------------37M9895EDf3m31e3Dk48gJfv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-bully-enviable-15b3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
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

--------------37M9895EDf3m31e3Dk48gJfv
Content-Type: text/plain; charset=UTF-8;
 name="backport-6.12-smbdirect-rdma-xmit-underflow.txt"
Content-Disposition: attachment;
 filename="backport-6.12-smbdirect-rdma-xmit-underflow.txt"
Content-Transfer-Encoding: base64

RnJvbSAwMGE4MDVkNzE4OTNjYTk5ZjdkODU4NzIzNDZkMWFiNjg5YWE2MDJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEu
b3JnPgpEYXRlOiBGcmksIDIzIE9jdCAyMDI2IDE5OjI2OjA5ICswOTAwClN1YmplY3Q6IFtQ
QVRDSCA2LjEyLnldIHNtYjogc21iZGlyZWN0OiBmaXggYnVmZmVyIGxlbmd0aCB1bmRlcmZs
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
IDYuMTIgdGhlIGNvZGUgaXMgc21iX2RpcmVjdF9yZG1hX3htaXQoKSBpbgogIGZzL3NtYi9z
ZXJ2ZXIvdHJhbnNwb3J0X3JkbWEuYyBdCkFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9w
dXMtNS01Ci0tLQogZnMvc21iL3NlcnZlci90cmFuc3BvcnRfcmRtYS5jIHwgMSAtCiAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9zZXJ2ZXIv
dHJhbnNwb3J0X3JkbWEuYyBiL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3JkbWEuYwppbmRl
eCA1ODU2MTc1OTU3MjcuLmJlMjZjMmU1NjllNSAxMDA2NDQKLS0tIGEvZnMvc21iL3NlcnZl
ci90cmFuc3BvcnRfcmRtYS5jCisrKyBiL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3JkbWEu
YwpAQCAtMTM4OCw3ICsxMzg4LDYgQEAgc3RhdGljIGludCBzbWJfZGlyZWN0X3JkbWFfeG1p
dChzdHJ1Y3Qgc21iX2RpcmVjdF90cmFuc3BvcnQgKnQsCiAJCWlmIChkZXNjX2J1Zl9sZW4g
PiBidWZfbGVuKSB7CiAJCQlkZXNjX2J1Zl9sZW4gPSBidWZfbGVuOwogCQkJZGVzY1tpXS5s
ZW5ndGggPSBjcHVfdG9fbGUzMihkZXNjX2J1Zl9sZW4pOwotCQkJYnVmX2xlbiA9IDA7CiAJ
CX0KIAogCQljcmVkaXRzX25lZWRlZCArPSBjYWxjX3J3X2NyZWRpdHModCwgZGVzY19idWYs
IGRlc2NfYnVmX2xlbik7Ci0tIAoyLjUzLjAKCg==

--------------37M9895EDf3m31e3Dk48gJfv--
