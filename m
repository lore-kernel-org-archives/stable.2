Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746405;
	b=3P+gn4bJ40X/gIfkE/TzLglGezhiFkds5GooA4UaFctph9qlU6WiwOqIBvm3hYapFW7j
	 RP/7vOqQ9JwkqTabUlkJhOq1eZh3Zl8SAUIhVtZ1xmVpdL9E6XeI0xnTk9xQ5xWS7zsrx
	 BuEk2JxzqvZ0FE7Jcy8qGSSYPIfx2lzsmErYUXzQpXJlSw7Am71bWExAyyfsFJdFn2B4p
	 SbgB6LX2wyj1GUEVm1ppeoKt2cBwdGfCWbq9K6nFI1CdaWx15hsVW6ZeuGPw9oxPH9EAR
	 /Gh8RsYgEB70GWnF3DH3m/JQG/mFSc6OR2bGqFWgLRJAKMGvemFA9pE4U0vpL2X8kAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746405;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=su8UXBRVhZFG+YPl8QR2JFjrMlAiyp931FF5v0ZWcxY=;
	b=F7GaNVaXRuutaVhsMtG965JL4vTt3qb4tO3+WF7Xfkb+2CNxxZ1/P3IhwcWjZHaPA4Uc
	 JNj0nQnQtHiS5ebaXGzWRq7xZrRdVyliuCYNb64js0G06mXvPCWTzjKtNkuNqazREhg3c
	 vBmHZa+R3MelX4me+02a25UVGmKnOXu78td/b9O9ZjQMsbVP4O4SpXHnMSvWeirL9FDrz
	 gPcSRakHO0ijn1T9wcfHd9NcUN7BhLTJpDeQSOzQe7ief5Uvxl1e7WqL2YfvqK0KoL5AK
	 tE4Bkr0LX7GY7vGZ479vnJYuRTYRQ8SxNFUv5PNu9MxZLqytaCM5IMRjOYSil0zT57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b="mMW/cpxM";
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200C606A31B;
	Tue,  3 Nov 2026 22:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7200C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=mMW/cpxM
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sashiko@kernel.org
Cc: chris.snook@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue,  3 Nov 2026 23:53:21 +0100
Message-ID: <20261103225321.19288-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179374297269.488856.7749172366095110113@kernel.org>
References: <179374297269.488856.7749172366095110113@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 2476EA50-53B1-4F21-A790-690007821C56.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 03 Nov 2026 23:53:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1793746402; bh=su8UXBRVhZFG+YPl8QR2JFjrMlAiyp931FF5v0ZWcxY=;
 b=mMW/cpxMRx2w0/dN4VfLVh8531ukBA38aOb+57Uqboi+NU4ZhfysrN1AKa5jMZegMbltZbBbK
 0fb/ZsMDqmhLxcWJv8W/KTnZ39VJiayY47p7TAjPMWEijUmX38YyLhyzJWtALI7KuroxRCUMcNz
 hrtKteC6iuTKnMOW/0zI6OgfVH9Cfl8bVh1+Aji+42Cdac84SIkF7p0tzM7XLTCW7sTbZYnsMZ1
 dnH1XSPRCJE0S9kQLC++zYeOfUyVjAOA7riuJYi7UvhdXaKl+4ur3QhWAao0s5SKKpsqhTWHlbb
 +Lhzh49WI6DQ9ntu+3nO0U7Qf05N9HrUAjfyc6hlNN7A==

Thank you for the detailed review. The findings on endian decoding,
multi-RFD error handling, stale RRDs after reset and missing error-path
work accounting were valid and have been addressed in v3.

The v3 now:
- decodes rrs->word0 once in CPU byte order and passes the decoded RFD
  index to both the unmap and cleanup paths;
- unmaps, frees and recycles every RFD of an errored multi-RFD frame,
  with ring wrap;
- counts errored descriptors as work so the RX refill runs;
- clears the RRD ring on reset, preventing stale error descriptors from
  freeing newly reposted buffers.

The memory-ordering and link-reset/NAPI issues are pre-existing and are
left to separate patches rather than expanding this fix.

Validation on netdev/net:
- scripts/checkpatch.pl: 0 errors, 0 warnings, 0 checks;
- baseline and patched W=1 + Sparse builds both succeeded;
- no new warnings; three endian-related Sparse warnings removed;
- git apply --check and git diff --check passed.

The issues were found by code inspection; no hardware test has been
performed.

pw-bot: cr
