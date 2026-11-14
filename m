Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629849;
	b=Ed3VaB1kayvPQAa1g+/HWVNHsKvkPRBgZC8TJw2azVqrzIbJR+7MQlCh1eyVAMDvonRN
	 Fnu7umin9N+xj/1SBz7obV2UZLQn3acdrktvLKLERSursuaucvF1J6EQv2ljg5XkuHie1
	 PMz2Pr3eP7mp8xa6TJ781iAj4Tz7nO2uTAQAxL1btzj1+PIKLBneCCDStuckT7HmVPHYk
	 elXZq3e9pDoS6LtwibOnpySIk2gs8xeHAvhvHq76EFwXl7pV0oaHzvI9xUaxMjKpF8lD8
	 t0J0SneBLsjuAoH1i5/NxqBKP3eep96o/6ir7tsq3UIroMFrSyl517H7/dRbsa002oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iB/K03lI4KCa3CigydQl65EWnXtxB4ckz0UoZC12GJM=;
	b=iOoYBbOUvoVXnQ5QLFOpS0l0ZDn+8jIhDMdap5zt9v+rrCLeow8YCWWrzQUQ7foi8nku
	 9utVmt3/YRyLwpnsxQRGsj90Pu4d7EU3lf1bCS+Ftm/bqN2YHWzl/kB5EPSruHX+kP2oD
	 iK5lo+WFJMFbqk0A+XiaDo7JteaRRyzMLq0RkiOoHhopwrgvkvLrcr0GS+IuAXP7vxQXR
	 5P4BXt2jud+Cbu7hDvNQQXvnu9RVFKR46FwVaW3Ua2/SS9fsTTMRUlVKJmubM1/PCX4Nd
	 DCKPLczfmYglC80hQ83EfoQkt0q8fyqWM0u7zERih7iGkgPjsLxAR9M+TjI5feHA9sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OuFlSZ8M;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A02606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A02606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OuFlSZ8M
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so2248861c88.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794629848; x=1795234648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iB/K03lI4KCa3CigydQl65EWnXtxB4ckz0UoZC12GJM=;
        b=OuFlSZ8MQIsrwDi8G4zjq3k4pLwpvbrHSKiXX6UOXn/y5OvcQVTwJ5FB83JYBW2ON1
         HPYLr1mbypw2ko+jPnccdjGAf9K+pz+0Em9zot5d6svD+mog6lio2H3/cJe5orVXUSyB
         wOAAyqfk/v/JdxSytCjnZSG/Dfmdw7i7anf/3UN20SwqZrlRlUy5b6c9j8WYu+i5Tyzv
         sxSERoMfahWESVOmlN45nFSnvZERoZJOu0zlqHsO1jfKreKbjRILtHbVTQsZYZlx7CMe
         M2IXtNcjwRP4mlcG+oT/rujgGAG7Z6CLWCwgFSDEBAfcdRGl9MP+Eu+eTgLc1dWUPmyS
         zPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794629848; x=1795234648;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iB/K03lI4KCa3CigydQl65EWnXtxB4ckz0UoZC12GJM=;
        b=zmas2jbzUNhRWPHtNGl59A99QOx7qPgJ/N1MRCXyroYuAxtNMIR9f/EO1jE2Ww0Ume
         HZt/wNeLUH0DJWnCbLdGg3/YWgF4DEdmtl2X3g1yAymu2RiEib2MS7XHYvC253o5zoky
         0CYpHjObpbvH7rFZUNiIoRU7z9XY3MiCBitXcaJPia1kAcde+n8NPhn4E2462fAe2C5e
         iDy5hx+fs35pHZmc2uc0x/W5jTCinByS1ALkXs4ob3PYflSuho1jFA8qcNYnbkdRNcqw
         2G5/p2RB5Io5b83AdDGRYRAa5tBG/jj8x4NVTtWoECdRksMJJ87bo4YoNgeAa5Cp77S6
         wUBA==
X-Forwarded-Encrypted: i=1; AL+hErHNwSJ553fvxCzGC0GMrIRM3pbD36eTNz8u9+GPDDC6KWvvv7Qfjy+Rp9thuSdhjmzIYR4LrFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uDAakxb8PMatEEHHcBblSTFp8Z7m67TTqeWVqURqEATUTVm2+
	9WWrKpPEkJom0iO5JkIGv1/I0Kzy2quVemOd+g+KWK7g5az8ja5ZIVYvzXYR+oeMPn4=
X-Gm-Gg: AYBFou1eCaxfYbDlJFwa1IKXe+m0ihbnnImvW16C4sZkQPT7xWeWO+G4JHYEVN/tJUy
	vU9mCUOL/Hvkap5cFSwXxiKiA+B0Mv83c3TjhcCegZE+vJJgH7AVtZEaTS6eqimG8U9QZo99FjV
	MIkBfvKq8k6ux86dtShTErVp3tUJhMJC6uDGB8TU4j5uf96vLtfEe35SNP+EOCB7YqadzbhCjKU
	NY52+3KQxyx6Gnj1D8wr73oZuuSxJGfmgoOpfOy2rZV31R2N8rr1F5Q+Mdr4J//5VwXjhgJpPkv
	GwvRnG6xVKIB0NmKjNv8Xz09CdQu2J6u7p6dZZnwwmPE/+578YKxfSgcRqEkR7NWIpFgLOJyUVn
	ZvECV+PKA4paspNYU0N3L4bTH9yWji1wM/dAz8tJCb3Zw6gmdoHXr40fXgGd0Bgxw8zNkWSKebt
	BMMlOH82Q1aspCzihiSSutVXK3Q4LYvhywDr7UaqwrDn2HZwzTsMmJvGIn34ze/yWv3+01CPTGX
	Pq4hVzzklDuL8mEER8Suns/A6gCvoK/qm4MpAZ1ui03bGCk/gFIIgsUv70G+ZUaa5WVgrqL0dWJ
	XAfr3uJN2w7/dyo9jfaeQP6Q5vg0+EDZh32Lj2wk4RPjP8ww05o4OoqX2nBZx43P7eqafur0xDW
	7wr3lMDo5CHeYTda4i0R2gt6bRnU8nWzOG8SSIw==
X-Received: by 2002:a05:7022:2390:b0:18d:96e8:b913 with SMTP id a92af1059eb24-1b503195191mr6210044c88.47.1794629848063;
        Fri, 13 Nov 2026 20:17:28 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:f861:b117:6318:c068])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm11046075c88.2.2026.11.13.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 20:17:27 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: mkp@kernel.org,
	James.Bottomley@HansenPartnership.com,
	ching2048@areca.com.tw
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	erich@areca.com.tw,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v4 3/4] scsi: arcmsr: wrap the type B completion index
Date: Sat, 14 Nov 2026 13:17:18 +0900
Message-ID: <20261114041718.551698-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-214130@kernel.org>
References: <20261114033810.549787-1-yhlee@isslab.korea.ac.kr> <20261114033810.549787-4-yhlee@isslab.korea.ac.kr> <sashiko-outbox-214130@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The review above is right about the Fixes tag on this patch.
1c57e86d75cf has no type B code at all; struct MessageUnit_B and both
doneq_index readers arrived with 1a4f550a09f8, so the tag should be:

Fixes: 1a4f550a09f8 ("[SCSI] arcmsr: 1.20.00.15: add SATA RAID plus other fixes")

Nothing else changes.  I can send a v5 with only that line corrected
right away, but I did not want to put another version in front of you
just for a tag.  Martin, would you prefer a v5, or could you fix the tag
up when applying?

Best regards,
Yehyeong Lee
