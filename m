Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4D19CCF7
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368655; cv=none; b=FdAJkp0vIjL0G+pn3Jjjz1QFakIjjyLBwTayjFj5fASnVVfIRi4fttZ/BUKFkvvddTv9GEbWImBKpxbgV5CjrsBqs3MbvP2fRFPsjymLA95DYCIUxfbMuR6Womm7hPbbJp4OGlVbjqgNbAA6hKzdhsU3zm3E5tEifOsbzdjnYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368655; c=relaxed/simple;
	bh=oQR1f1RasNwAug4NFhDAjr+2ufczJr8XLJFbnI5V+T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Azf3TwWOeIdhXrTwKb9nbOHlhNNlKiG7KtThj4AQaignypkltbvESZRdKAIcirMb6DVkjH1z0rmItaYOv2XsnHSox2U/9XYaE2ch0K8RAt29chNngn5r+qp9up5V6DhfwgLYnzJLTc/6BU7+j5YKhE5T2NcZmCOhdPaz59g+vv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=ZUwvwRE4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="ZUwvwRE4"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1189100a91.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 17:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792368653; x=1792973453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQR1f1RasNwAug4NFhDAjr+2ufczJr8XLJFbnI5V+T4=;
        b=ZUwvwRE4huz7g3TAb3YokAiF7pX+g9Mn8AlR+jVJFa0Aqzk92oHDAg6Al8PgRqigq+
         1EUd6OeXPKSV3hwmfDRYup+KG6FIiNiEKejP4sKvNXhPGVXTVldAyTOdUyywEYz8EHLf
         wolImaXuV5E8DVS03K+GCrN88BH0/giAemGP/UdYNycEfJdkFtmbaWWLxItE8G6qjn4b
         YLb2BGZEMU2iJa3o18G24x3AwNmn9Y+o4qEMdmeHkuRuFqdTVj9sLIqp9U/zMflaEvtR
         WuuGd5QGoAunkRnCMnQy/NkC0SlnTOCmb4BeUqmPhK9qqd3hZPTpBO6UC1UA/uCu9Srt
         41zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368653; x=1792973453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQR1f1RasNwAug4NFhDAjr+2ufczJr8XLJFbnI5V+T4=;
        b=2NcA4YWq4rvm2rP3fQTmBj2Y6CVfDoiY7SupoF2Uibvb9XULXyw0HRZjA5FDWSE7m0
         NLOIaZDjVhpxPO4nu5bmI1ZKDcyhVa/LunJx2/bn0OCtKIEtmFow5CMmjEOL5xML4jLh
         XnOqQYwB9UAfVMVmhsqcr23sCf98kaKH/6tvNgPxk9lIFRQSeVgV/M/sEe8Lsr7UobNL
         L3wpIuKq9EZHkxzOIwQL0sAL8OUQipTs6AtJgJ4BZ1dGyltocwbygbFc2NiNY8PADJuk
         hUmtY4yolKIq01GIKy2dHpFQfSkpJbje38qDT174pLAFaC3RHrcLMqizS6X9RV0wTYPa
         p+Zw==
X-Forwarded-Encrypted: i=1; AKwUvByjTl0V3gTsL39YSsnDPwXIujIBCtBC6mG37uw+dC5wnQnvnYY1PBxak8e/HU8ENwu36xtKb0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIUp+pbaDSntCc3U7cYqJUWUcAtw3rJ5wG0sxJr12DwbYcOWtZ
	fviHwwpDSuHZybH1yIJibb2SpxvfyvTadDaO2CwHj9a82ZcxFR84BAIt82BTyseBRo0=
X-Gm-Gg: AYBFou1f8IufoBVUTDHH8TCD7BPPtPnN2/4zV26fey382pzeQPyIC2Bih0OyR9lHh/1
	TeI8q7Te84c68P3/v1ccyrHfByPzXizlV6T1GwIUk7tos211oI593vfd+OxahOu+I6KbK3Ll2qO
	3oFSOcCqMeQyp8PKEoGC3e1sSntSCYxuCipBUxjwinsC42W8mG46ccFYIXwE6bmeEMPIarrIAPv
	Dwec1/oGoAZVWFIO6eNisnVdoQHejhgptDyVhd3xFPNF5qNdOLfQXwq4f2Bf6lDFHnCfv+7hok6
	geTvUG6Ojs/1wilv0JKsTw126RlxVVGlS5XTvuPXsckow98N5OsrYMiVVGjqDl/87In730Q1GQE
	xlAKpXRsILBsfAJaMl8lKYEMKoLthE1Sp3Qu1rfv3n+uHLLm/BLYgAQJHI4f49kDWSaD9fHH5wg
	dTbpDQVO5qshJhyx2DZtA6W7gGZoTdCnnZREYmp71zcRYVafok4Aln3SiMs0uSGCN4Xfqm2dZ6m
	cIodg==
X-Received: by 2002:a17:90b:4cd0:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3acef104296mr5267670a91.11.1792368652920;
        Sun, 18 Oct 2026 17:10:52 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm18750297a91.3.2026.10.18.17.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:10:52 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Fan Gong <gongfan1@huawei.com>,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Mon, 19 Oct 2026 09:10:37 +0900
Message-ID: <20261019001037.3496843-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018170531.bILLh5Zw@linutronix.de>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr> <20261018170531.bILLh5Zw@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

A well-behaved device can't reach it. rx_buf_len is fixed at 2048
regardless of MTU, so the frag count is ceil(pkt_len / 2048): a max-MTU
frame (9600) is 5 frags, and LRO -- off by default, capped at 32K when
enabled -- is at most 16, both below the 17 the array holds. Only the
16-bit length field in the completion descriptor (RQ_CQE_SGE_LEN_MASK)
lets a device claim up to 65535 bytes, i.e. 32 frags. So it takes a
device reporting a bogus length, i.e. broken or malicious firmware,
which is why I treated it as a robustness fix -- I should have said so
in the changelog.

I found it by code inspection, not in the field, and I don't have a
hinic3 card, so it's untested on real hardware; I reproduced it by
injecting an out-of-range length to get the KASAN splat in the
changelog. The netdev bot asked for these same two things, so this
answers it as well.

You're right that the bare drop is unhelpful. It only surfaces as
rx_dropped via ndo_get_stats64, not in ethtool -S -- hinic3 has no
get_ethtool_stats, and the stats series in net-next doesn't export
dropped either. I'm happy to add a net_warn_ratelimited() on the
discard path in v2; it only fires for a misbehaving device, so it won't
spam a healthy system. Let me know if you'd like that.

For reference, eea does the same thing -- it drops once nr_frags
reaches MAX_SKB_FRAGS.

Thanks,
Yehyeong
