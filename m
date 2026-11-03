Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716291;
	b=cRPlM342trB7V3rS/ps08WADz/SOVidy8PmMqZpT3pOaV/6ofqpzxKQaCwdXkmk11x/l
	 oHeeumarAS0nxJDplCQ1+TOi6sEPK5q4wXaLBZfslqKzXdtJS8tuXMXbbY9YnXZCW48i6
	 s1/Lg0eZrQwtSG7uD85XY9iSMxyMu4g4xAMghATbImNOyoIAajtbhbTlOF9EZq6kV8hMv
	 FE2+86OKOOeZLv7gmxRvU7Z7Yef4aTO9bNEcFUwwTh+ChFr/bQ3EGNtc8D/EYrXu0wHYj
	 a/n7/F8Tb92my0dAvQgOHVEwY/1BLK0Kyl3c70hMsd4WBu5n6YvRjwHnOXBBnAz2wbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
	b=Vg5GVYMgaQfX6a0/8I3qS6cE6SMSRFCY0YDzPpW2yysFZvAI0ubJMwWZIM4ii64oCNAz
	 UjCJlzhH2vQ7yJhE1iUt+gaY+kun5dh50yIPqtmFVrvuZ2miuQhkTHkCocru0L4YmW/7+
	 G9AubOslvbwrFUTiFsGAnwCB50u2gfNtWaCuap6Jwutc2jGyH9arm8pLwbmWAlij9OvxA
	 Br9hZQyjZL5hGTdi/NEi/5GAzYcKjOS75cqhwg+TzuT1ibYoYRNoHZ0Ri1/ixNoZ7qyv+
	 zb45BwPxDRiNUPE7nOxd/mN1xnr+/Uptx6GuTfjuAc8liFZPppYGf97ZSlwzwDD0hlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="gKjJ/6Sv";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19D6083639
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C19D6083639
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gKjJ/6Sv
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a3c08d6928so5345410c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716289; x=1794321089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
        b=gKjJ/6SvSISn5g6EFsgPui5YEYC/MbDN05MclZGEWTEgK+qxGLT2Pqzke2uXQS6c9U
         YfaHxiTLnY7Mm2g2eXYxsq+GmguraXytboIiKKpG2bDndyvwy/TGithPIDvxJSJG+G/g
         qGR9nIuGQxyGmxV6pT5DM0z8EndE4zDPoxsPKNQHUevSm/NmDC5FAzBIxehXWW1MICJP
         VkPwz9qSMV5dbjL6cWPjntuBAi8pRY0umW8vztqtlmNm6yxxkzOEyA05bn6l58XWzSmF
         ZHEi49EDPDY2thdsvCrCtfCf+SQshoj90f+9nAGDyx1BidsELgEhui/ume8n37Ga9duU
         H+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716289; x=1794321089;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
        b=xRV7t5tGSbOOQqce7nyugYZOcJ/SBFNWr40aywFcYRz4dEJRyjah1k549Ls2ZctMBf
         ZOKWA3MD+RcvX/Mc/GG8YFndQYiGxocgfHpnwaI9bLg3otM04zRNOXqw7EN89QKO08IH
         7bKG/H4tppahm9DigI4XqHtlrF5bEG3B/IDYhpUNJpgogdwHVsVmVi0FI/N4QSUfRO7G
         o+vQd2CqgUg+t/7IiUsJfXF1ODgcEgqIOXeQK0TUPnOKL8kOP0T70b3oDqMtnd48zEOE
         8UZosXIep8GxZq5PTmGC3VgnA6eQFYgSt7AjPNpnRIDi3BXuCCwHZJ9Xw01Q7uPFmJEe
         LOTg==
X-Forwarded-Encrypted: i=1; AKwUvBzqJ/osW85ns3OKETY4WDyLm55MZUytviBlIUwOOcqcPUFz6ZbbDKLMF8+EpLzlox2qkR6okMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S/6xaDbPw2lD9N2DcmCKAhiyygSFb0AmK06g+ZfBMZMYSkIkY
	g8HEbGKmJIY8KsY9NuMrJ6BAAzKte2LvxK+yGi5B4rsBOmHozpMD9U0X7oIbLQUefqw=
X-Gm-Gg: AYBFou1s7elDqCtJ07YqA1lYtyLy/zaa+J77cdliFWARdRJv41cgY7sKIuv6BoGyZPb
	S9xpylu90ELD0Dsk2Yq1VrlLMAFn3P4MxBf6JNZC40MPrl9jrxWNosidGwTrpkYQWet37CXiD0g
	vpwYir9ybO9NaxHyPyxAZMqclGWlA/I7ACa2ZHvVYmUr8U1wK2QM63I1nV2s07icdpAzCJr7CMX
	hQJ90OMFMw9WcZWGxptvq8yoDVZqc+tP53zPc9rpvQHJ6yztXPzCTtkSrxUl9nOoxTZ1KyaB9Ug
	lQ7u5o0jbERP7DK5pGJ9Ykgv/cx7Hp6QzwRNd/hHi3W1C004s396ZpjU9vmKlNNTckfhVsAqSAb
	DTZ3NGydiFLSPodFJdZ/48P1KqJ/D8W+I0SEAlTnFm1j3wwxTtSQta3Uh/bS7SWuiVPyZNwszwH
	jsP4iJNH1yZgvMYaJdcsGEEsgTyGiabOXXGmWCoFR5LgIOXS0Z+OVlYE+pjZisT/Wf6pcMi7OZK
	vVcAu52iGXpTWMexduYa8Br1ZxrQtnArslQOil+gcCYRAt+LjJIm6D6MNTDiaJdJWwYnOR4DyBP
	ESaMDSPJpWwbUe4IubXPQ6vA9MDvHFoAYqkU03infTLf5KYeGcWNBwnaprLqlG6riaaPiu6LYEH
	gDRWpaXI6jzpY
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr21036321c88.41.1793716289438;
        Tue, 03 Nov 2026 06:31:29 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot@lists.linux.dev, 
 syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
In-Reply-To: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
References: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
Subject: Re: [PATCH v2] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
Message-Id: <179371628848.3691261.276757911523604089.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:28 -0700
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


On Wed, 14 Oct 2026 19:05:36 +0200, Krystian Kaniewski wrote:
> A KASAN slab-out-of-bounds read can occur in blk_mq_free_rqs() when there
> is a mismatch between the number of hardware queues allocated for the IO
> scheduler (et->nr_hw_queues) and the number of hardware queues in the block
> tag set (set->nr_hw_queues).
> 
> This mismatch can happen if blk_mq_update_nr_hw_queues() fails halfway
> through (e.g., due to memory pressure during
> blk_mq_prealloc_tag_set_tags()). In this error path, the elevator is
> restored with a larger number of hardware queues than the block tag set
> actually has.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
      commit: 894e4e6084924cfd590968d45fad20908e02ddae

Best regards,
-- 
Jens Axboe



