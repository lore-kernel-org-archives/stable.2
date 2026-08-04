Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48391386C13
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844825; cv=none; b=P+9wYESOJY2Tc0VEu0ZSTj0Wg1th2fp2iBV8fFVwipHomDFMFoN5bQQfmll6WlIFvGczZHe3D7gW8bcG1Lz8fO2vRKB4Bp7GzPbAmiCn0c+EYgpy7KDHA/IzZOg5+vgRn0DW7+x2NetNJgIJvzxDFBLtEFbWu15FTRRASL9Oq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844825; c=relaxed/simple;
	bh=Y1IZ3brM08v8p2grI16N93TT6dsj1XYGzO1ReHQpQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1EghZolGinoVH7/3DLK9FSOf22YQoZs+CvHyZ+cpDJreFLI0N0+Zj9KT8q/J0OUnQQbOvMAauYimUwDT5Ufrfkgeu/wl/JrRojmK4UX1ChCySjRq+3UusEGdM+lWgwbr2SNt8uEmOU7Gk3yVtY+CLB0cfnLUtNtgnwBZB56JnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv5zBkMt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv5zBkMt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fd66a094eso1399610f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844822; x=1786449622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1IZ3brM08v8p2grI16N93TT6dsj1XYGzO1ReHQpQ7Y=;
        b=Gv5zBkMtWsJ+Ox/3Q1ahdPkZ/HfY1+8GG04v/zs3yXO5Jvjhrn35cxKRMXilsgY1DK
         +c8JiqzfRHkewyQZqOBcwfbuRTdXLLffqRlS85Hem5QjQmWUnar0VjYwOZhKBpyU6GDf
         vyPuiEGAlirsDT9rsPrZkjn+Aqf+L0PvgBOYwDEMjsYw4uJJ/ErdtlTnA7VbCSTXYfOF
         vc8ls+xD8FO+FBA0ULQ24wOHICZh0NH3PF/cH+8P48Wvj4jxy9rFGFmTBU9MMyRuHOg4
         q0cHAlaKjR0fMsi+jQh27Vla2i0ucbfbj/NJG4tBGZEasQox0ItSNuIqt/4nAoNznFng
         KN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844822; x=1786449622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1IZ3brM08v8p2grI16N93TT6dsj1XYGzO1ReHQpQ7Y=;
        b=F2tVFoFiYQVch2VYPWkmt2IDeP5M3o4Zvy6wPfC8J1piDPGEL2FxmB3XnbJ6MjPEtg
         E4M+wZaf7ceEhsmvuLKpvLqX6z2Wq/iFicw+Z9Iztnjjxx/cYMqjRD0MzCdpD69A1SJ+
         nhnK3SQoLNGYIAAv1c0D9mhk9HwsJWGOtviCBUOOrzBljiKQAwsw9Ftcgp7d8phi3nQ5
         H5V0W1ZO8r0Zy/eahBJhjP7jdFWYbUzRwtpsVTZTgvWV/wmvAOVuHSkD1YuIS9f6+iGZ
         twzpuTiEuajdhByHjml9G0BnRU34bpEhMswqbRf6MUGIhxhWvRG4rwFJsA13mvoHD6e8
         fDjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrA4JudFuM/TQUWN0X1V3GOXTuwVHAcIOtL/UUh2yGomZBJ3MdCoSNO3Dmr4JnxB1Kth14vk5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqwJi6w75X37Tx7BFJu71aRZceWyKyU9jQe2aS3khuSLF+laM
	cNj+LHQ7a3YABUiTHaTOsk8/n4IdE9bQ13e6dnane4vQXjZS7RIb4yDG
X-Gm-Gg: AR+sD11CK4SPy+UczQHWnwa+satuNtfp8vS+G78+CiR1pJHNaCNu/28hArER1+hVWgL
	hPdQWKgWz7ZvEjPtMEI9wV+aRiSoNrwIYlEERzRsOJ5p2/tz6mmnQkJUtcqEk5P7gEKJN9FYtMO
	DQX5tGchOSmOPePKkkWGZFFh38O8AD1VpzS+PcFwPQqJ578hDf7j/EzUA+jOlOylm+6GsJj9DUQ
	T67xeNobrjF2xdn87WJNI21OF8WViuNQeoyrIXdtY4jR2ql7HC6DvyUUmRPvOcVpiEp4zir/6ol
	MAKN8Cs3nGnEGrVf6UjaH0zZyKx4ZEKPjAFNRQokJ4Ymf9Q67JxxkuVEsYYkkb0DKY4M0vfIyRu
	om1fGg6Vj3FGcwCrE77QqgADFIK2VoR2Z1odm5mpExs4/cdtxfGM2gzzPAXIVwlWOf3mEgIPcPl
	aj/bTAzsNtThGQs8Ll3nv8bxKrwGxzaeYMuACr+H7+cBaqcNO7yEsRMBwl+7wBmR9h+tzG4cyia
	hGJ3wFscL7hNWH9aev/cauUvSuU0j7IEDW5cqA=
X-Received: by 2002:a05:600c:3226:b0:495:3f99:849c with SMTP id 5b1f17b1804b1-4980c6753a3mr190119675e9.15.1785844822328;
        Tue, 04 Aug 2026 05:00:22 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs192228.centertel.pl. [46.134.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fe2f4fsm96081735e9.10.2026.08.04.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:00:21 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Tue,  4 Aug 2026 13:58:17 +0200
Message-ID: <20260804115817.16886-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
References: <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/4/2026 Jie Luo wrote:
> The CMN PLL output clocks do not depend on the AHB or SYS clocks. They
> continue to operate correctly at the fixed rates even when the AHB
> and SYS clocks are disabled. Therefore, once the CMN PLL module is
> loaded, its output clocks are expected to operate at the correct
> frequencies.
>
> The downstream consumer is used to keep the AHB and SYS clocks enabled,
> allowing the CMN PLL registers to be accessed.

Agreed on both points, and they match what I measured: with the bus
clocks gated the PLL outputs keep running (ethernet and wifi stay
clocked), only register access dies.

But I think these two points together are exactly the argument for the
patch. The register accesses do not stop when there is no consumer: the
CCF invokes the driver's ops regardless. clk_cmn_pll_recalc_rate() does
two regmap_read()s and runs on any clk_get_rate() of the PLL and on
every debugfs clk_summary read - the latter user-triggerable at an
arbitrary time. clk_cmn_pll_set_rate() likewise accesses registers
whenever a rate is set. On IPQ5018, where no DT consumer exists at all,
every one of those calls after probe touches the block with AHB/SYS
gated, and that is the measured hang - the boards died during boot with
no userspace involved, so an in-kernel path hits it too.

And note the consumer mechanism only guarantees access "while the
consumer is active": on the SoCs that do have a DT consumer, a
runtime-suspended consumer plus a clk_summary read is the same
access-with-gated-clocks situation, just harder to hit. So having the
provider hold the reference for as long as it can be asked to service
clk ops - i.e. while bound - seems like the robust shape regardless of
platform.

I have just posted v2 which does exactly that, in a cleaner form:
devm_pm_runtime_get_noresume() in probe, so the reference is dropped
automatically on unbind and the existing put in the error path stays
untouched.

Thanks,
Stanislaw
