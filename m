Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795835782;
	b=iEzelOa+9QrTmg6D/kZ+0jL8sc6T62vxLRjVTx3fJ6AYLd7x2xuWvOBo1iK5u07/JA02
	 LnZQSelSf2VaWGs/joUkoc0GUw+AIBR6jqN04LCeTSgEmfpjyKiYEveOlbK8Y9LkcIC1U
	 9im8Tod52LkZ/FVlvE6sI0LdHbhDRh9jzKRg6D5FS3fDD8f6PX1oSR3BGtxIwphNvGLq5
	 atqokEmS5VrhHZDiG6+sR6HK+OKA+3Xh5h54rZQJxaBUgeONFxcWVlem7lBIZtaECy5su
	 07NU8LFK1/ZlOA6SoDGXQj1by7LDdRnHc7txNTnvyTilX4H49Vws2wb8957EU6oQlxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795835782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
	b=Rhd+ZyRasNqDWkaZWSSZ4tKlBKx1xLgvHxtjP35uJ7h84xtfVfdqx8TovnQVLe8YJiA1
	 9DTQGUB+OMN8uswSmgJRxJr/Pfk86NpTTj6gnkGuvKXG/YnIN1gXRmKzZHZ8UDlkjBCWZ
	 r2IxfmM8TQpDcFEYqemKBjEtZez29MzEcm8N6sPhtxPOSZBeiVFrhvpEiXTayZU0M0WLf
	 fEM5HYSCXuklS8du9Qjov3KZR6n9cnU5vpj1LyqqbEJY9dbI8q/tb6ph0bHm2uIPx8wlu
	 zqmDciOQuBlxFeVgRAFmtGrc9/dU++UhGZ9V6KGMlA6KZ8L04lXhwoAdEggepsjRryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WR3iI+MZ;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A9606A324
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 03:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6A9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WR3iI+MZ
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso11966019c88.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795835781; x=1796440581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
        b=WR3iI+MZM8Sx695G4+b7/SPK73hGU4cE4Qu1+7lznzVRy9uR5PJ35VG6f5pTrbRFyY
         AIVQjcLeImXwpU8a+tF/IWC4L8BIhkXR/j3cTsB4AKSNdyAEf6y07NrQ4xW7C4Y5Jwey
         tdUuSSdI7epNQciLkyqg45/y0f0f9n9lYSa7JCftlaQYlIZ6iwyHLqEdJwlujqcQFtlg
         nrYoxbd2x7LeKtljtZqE3S8Fy0gRmiwSGLkYTfgcx6jz/E5B+KAwO4fhqs8dcGezw1jL
         Hry9F2MwN03ja63mizJg66neaADF7CYPIxRS5+14C3mK4xZZd35pUou7h+UqUUyRtTo1
         yFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795835781; x=1796440581;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
        b=IyfPaL4BtAF1dyEu9+ryhnfWEy5fO4LE9L/8tXe+5LIl6rq9NOH/rh6OXxs2MJEoH2
         pacjKBpSjQIcrMEPrGADnNv2kICcQtpxHsyN+f+QLz9kLEJuz/Wnu5p8rgGzvg60EEvI
         r6IBi+rPg3i4bIRxe49JcnKA0jHjoiUK0kpgRvVR10lgdIjedRcSxE92A2psaFbl8TJt
         qzsSw7QtNvfX0CP7kZHoJpVhJCaLBN5JNQNK9ofh6sjmUOvn/yHJhgJP17Sx7eURV6Ug
         yEoS6WVmCvKdabIvJ9/K4WY1e3uPf+GKYgpkyC/eaFWnJn1G6PxIvyJV9cGjStFJwjQc
         9cTQ==
X-Forwarded-Encrypted: i=1; AL+hErEYgE+LYVoweAEjCSqV2Xc8CMYmzSMCymwEp32Nwn51yT5QdGquJswtJaoXvVMBRGjEQiQlNCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q6I/PYstlkadyRvgMocHlbUD6bZ1lfxyG2jkyFwETtVC87e4P
	YrqS5p8X5DZMMayo5M/Xdw/tuNVBisvB4yZZuLk7RDtZfKq4/bciifaKz7TOGYDBz2Ab81ugFaH
	NikfxeCQ=
X-Gm-Gg: AZFdTZeihbcNFYRNcExRR2z4Sh7XlGyCyetH1B28/4CAb6gpl3eEzzoLHoPqCy9f42X
	TSU8/hJlqguHVg4sMlAp+/SG5C0PuMQl2Kv4fUSXRPLDs5/QWsvOvHhVm80NAwnrIPI0tJbDXM5
	xjmkg0DzeG01liH0cUEzNIQPOYwp+1x+Z0UHOT2+cYgR+4BG/iCxPHZtayjSZSCpoy1GSC9SUqf
	d10+WXcjGhIHmeuB2Glggfm+dN55UnSRQvC+pBBe8SqiZ8wPzAA8Ggg5tF9q/mNgfL2KBNeWaFV
	iqEXbwxB1fOlcJvlmUTEgJifvw9/XgPE65t0Gb+/84B1uTbj95dJ0oNVMqiSAjCcqXvITGVuOPl
	7e3Zk2mtnZZ9+i4/I5TN3Bw7l2PkRaKsN40tFkdivm43wzs0uGmQyFSj9deUumlaA7OGUxtDl2v
	qS3E3lLOXdUByCRMZEazXyQRoWOAlX6VWFwF3hgdF54RU9goNwnlzPXySiFhQ+Uc9M6lpiVIlzT
	40kAvkzzdCGJ8e0DjOrKPNSZnKHjR9bjO/UW+rrzI2bbU9C+tdOmr2Z1qTit+6Ci8ZQhIqQuxb4
	cmkQFXFwwUhM1vX4oVUf8QEk+CMNTQkRkC1+87v0u9lEMUF74YPysNYUWL+mzZwBhXh8j1ixKti
	5/WGE4NvQI+fBnfEm1Ue358/KjhgxBt77swS6IsTjZF5i6EOx
X-Received: by 2002:a05:693c:69d4:b0:386:5adb:ac25 with SMTP id 5a478bee46e88-3865adbb1d2mr20378523eec.22.1795835781504;
        Fri, 27 Nov 2026 19:16:21 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm36623124eec.17.2026.11.27.19.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:16:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 florence.schadle@ssi.gouv.fr, frederic.tronel@centralesupelec.fr, 
 louis.rilling@irisa.fr
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap
 reference tags
Message-Id: <179583578039.94675.216278078774861873.b4-ty@b4>
Date: Fri, 27 Nov 2026 20:16:20 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 20 Nov 2026 20:56:44 +0100, Zakaria Belkadi wrote:
> On an io_uring O_DIRECT write, bio_integrity_map_user() can attach the
> caller's protection information (PI) buffer directly to the bio. The
> block layer pins the pages for reading, but reference-tag remapping can
> write to those same pages.
> 
> A caller with write access to a block device whose integrity profile
> enables reference-tag remapping can therefore modify a page it can
> only map for reading. In testing, remapping changed a tag in the page
> cache of a read-only file. With a PI buffer backed by the shared zero
> page, the kernel faulted during remapping.
> 
> [...]

Applied, thanks!

[1/1] block: bounce user PI when writes may remap reference tags
      commit: 348d25516523c3edfec477d56abde2b2491dbf9d

Best regards,
-- 
Jens Axboe



