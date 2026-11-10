Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280121;
	b=HcaRy9tyab27U3F8O940ka97nExy11qvVhzdW7xN1z4CspIb+IS2IMeKX0YvKfLd1OuP
	 UXB4uLTjQygu9EHvJbva8dVzQW2LTMN6kaCiYbqT0Us43RIdtwKC6FwTMCxBTg1YQYfEj
	 zKMdIppMjOk/cJbvvOaWMsZumj8CLgGf7b5rUjKLmL9PDeQCDhrlebAuu+uCWBYUNfzH/
	 l1/Mk2V8D/zGWsNopyKPiQxJVw5L00LjOhvE/vVvmHbWDPUG7hgQvq8hCkReyoXAtQXHF
	 Gs+mf851iuFi+fIlC92rhlpZg7bb6PgXJ7aaLLc8cVVxesDBCVKcFI2+0DJjiut9F5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280121;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u0WexQiYcFsTUz3TiJp+BmJsyIFP85/+eNxRbuvwdeE=;
	b=xXABzLo2sPkOEt3jJc2bpepMxeC4Tl1Npd7IQqggA/P62LTfPrFgJmPL3J5Vb2/Z1ig6
	 YgLjg4TJtCYQdmaHZBmuqJghL2xzMS13WEFdPSPeW2pPZKd5wqPzL3bk8VT3i+M+FhQ90
	 co5gqz4OKNKl/PBCo/c32VBOmZ7Qxd0Tj2zLLLcqrf6GznB0ECe2k4kWtQSOHbFWEpqlS
	 7bJlRO3hOYPk14M9tGLt3xXws+Al53yFFzL6ysjZ1L7O8MsXFBr3XL1iyluzv6iE5y4rx
	 6rC5i5M9xTWwMZINBlbkowwvy+230ickWcX7Nh9pR89Y9urxcevkG0tvK2hJXNRKWDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="Fs0URh/P";
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45D606A334;
	Tue, 10 Nov 2026 03:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED45D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Fs0URh/P
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794280111; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=u0WexQiYcFsTUz3TiJp+BmJsyIFP85/+eNxRbuvwdeE=;
	b=Fs0URh/PZ3u4XEEzSG/a/AQKAR/X6HgaCUBlNZnmdQqW5y3c+XyAxbMOFJJUmcDY3aSFfwTOpmMpDsNuIl2M4anr8xs9ASpjb/wKSqpVHGO3X8YaWGHvgaraBM6EsBAiHU+0XwLuZRTYE+P+c7cXjV+IPJDoZR2ghDHxF6ESp3w=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1069233|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0209474-0.00293205-0.976121;FP=16677591614755782120|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.k-dniAt_1794280109;
Received: from 127.0.0.1(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.k-dniAt_1794280109 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 11:08:30 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ard Biesheuvel <ardb@kernel.org>, Matthew Garrett <matthewgarrett@google.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Date: Tue, 10 Nov 2026 11:08:29 +0800
Message-ID: <179428010969.3920616.1180194759290419954@xiaopeng.com>
In-Reply-To: <au3xN-7onNTtgceh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Jarkko,

No bus interposer is involved: the threat here is firmware shipping a
self-contradictory final events table (preboot size larger than the
table itself), not tampering on the wire. So the quantitative
question - does this actually happen - does have data.

This area of efi.c has already needed fixes for real firmware tables
four times:

- 05c8c1ff81ed ("efi/tpm: Don't traverse an event log with no
  events"): some machines return an unpopulated template table whose
  contents are just garbage.

- b4f1874c6216 ("tpm: check event log version before reading final
  events"): several Dell models froze at boot because the firmware
  event log and final events table did not match each other.
  Fixes: includes 166a2809d65b.

- 80a6c216b16d ("tpm/eventlog: Don't abort tpm_read_log on faulty
  ACPI address"): a Framework laptop with an INSYDE BIOS shipped an
  un-mappable TPM2 ACPI table.

- 48cff270b037 ("tpm: efi: Use local variable for calculating final
  log size"): this one is the closest. The same subtraction went
  negative and hit __memcpy with a wrapped size, with a real oops in
  the commit message. It carries Fixes: 166a2809d65b and went to
  stable.

So the corrupted-table input and the negative-size memcpy path have
both been observed in the wild, just not through this exact
combination yet.

I'm fine either way on the tag. If you still consider this one
hardening, I'll send a v3 without Fixes - the change itself is not
affected by that.

Thanks.
