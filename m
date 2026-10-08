Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413094F5E0
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486078; cv=none; b=mmG3AKJqP2p8/VEbeFLr+YmYtkY93FcJGaeCAbBH1UUDWc7mg35LFxFmlW2qTbadLhDkEU6fM17JHL+JDwHcGF78gP/HrPl0KwTsPyQZWhvv4qHlnxpr0PVthCY3WY0YEwTPUIQSz4l/+Ib86+nSAiH9xXM2c3djy4MwTpX8Gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486078; c=relaxed/simple;
	bh=2ENKqBaTPDdQhMdT3t9NB4MtzLMzeAWRcMV4ixhE+9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkJJY0z2GqgAW+P9txnP1qI7ew1MHHjbERlzOwon5TNdGogaX1SrW+X6bEI8tD6y0xXZjyffO6G3mRvdY0dnhrO/fygysE9n2aOlPMiB9FKZCQMp9SPo7c3ODaiNlHsfmO4MBWW5c6chMGej0UOd1AdCDWM7x/EMlFcU4+FKoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MBcEWciw; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MBcEWciw"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so2052468eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486076; x=1792090876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FggUo6U2laVtXWdbUW1VXActXrfV6jQYFCULV8ijL9s=;
        b=MBcEWciwLi1bYaNc9DFKUuNiSI53IjnLwgJCZhLQJiU/6yWp0TAhykhrCavg1MLjj6
         xs2GQJ4I8t06iPv1pDScxfPYVMll87LDmRvrO+/y5Hz7uPUozpZdadgLAPHvB/INvwV4
         0oweqVEyizdb8AYqdXoIlIX4BkS84zpQt+lYr8X+bJ2K8F2JEZMORSdXtPzx0QFSDdaW
         2z+E61Yr8RQ6HpL8Ufik9o6DCJq5YMgrK8ydrxJ7hkUCAu/I0dkU4G0TjjzeFrWPEPnr
         7v2Ad1TnAUs7AwVOZmAbkuJq56A/jKNKOJuyM9GKPwHLSLL5z2a5lNIvAZqScau5psRM
         rkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486076; x=1792090876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FggUo6U2laVtXWdbUW1VXActXrfV6jQYFCULV8ijL9s=;
        b=e1ofkzNd8m/N9Z/1sCyhxJnfQTCSiBRzPL1x16ae3FY9isuWn8dpxEDd+jnx5ZbiRc
         34XM6dJ50A6+9VlLVkxrHTu+5j9BXTjkBvlHgU/+CUKnBcsI+urX+ykEhCkPBJsgC8QI
         XF0KWhEJOa+gSvH8JrL1MRq/xuoaOxOuN/OBrgT2AOByZqLcV1lJXgBJIJnlrxkmsSF/
         TsIxX4qLt6P7CcK11K99CeUhUASAfpvu+rReE7oHajyWU9xjwRl5dK40ULp0IOFgbPvl
         Cb7i1mbfrlBZtmFOsNibzrmAuJk1mBfey8oNkxUUaREv/vIFYrv4iY7dPAPAJ6ciIsH+
         FbOw==
X-Gm-Message-State: AFq9FYLxrCnXsUuZhzSXFow9Td+tODMlM6o9EksaQsEZTDQAw5iylGt0
	p3ycnvz/Eu+HCaZj0iL4gQDUE4IiJuqnSyr1dVZhSD9ktNROIwRvvec/9QU6FKHdpOHkqyoQ4OP
	E3B5Z8CEJ6Q==
X-Gm-Gg: AYBFou3mPtdZ+ePrjupSWP3e8kILB03bBa/R6n65BT39XYFd19ZVLIGLNBGwRXF03eM
	I0T7+Pf9+vkN/dhLksvBsIMpvkvFtMc+5XdUUD1X5aBA10f9R6BVd/oqOZ24KKdE31wX3zJohan
	gACaNv/R8Wks4LMk/GOzYLobYcJ/nY5fczeH+I06kEQlQTLB/IwNY6mjJQ7KezM7ToX2rC8nmUW
	Lmxol14saSJK9Fqb6ZVsunNa6qpPrFRXRzzFUYBmrVP4IjESUDdhUcXcRru/Bpc+sE+Zh809nxM
	CmPsmY13X1NAP+NBlO4o1+VIFJS1dgPecLtptYb+1q+2NVCvKzTkhamO05939jp97AZv5U7t6md
	jbK3wfyl/NZj4eTLhGnoQWSN7SDWSNAwMmluQc/0wphEEDLMTQJkp2gx6aWjqpfBLQ09iApjWZL
	KjcPSgGh0rIpdVLU1Y295ksNAGn0JdJhnw+o97J7F44IkrMCpS/1vKmkcJ0P6Pk5hTqntpeyfn1
	3cP+B9CiC2VmIa1l8eLMw+IDTHdF0GwGYFSMQzYyaFw6EcKCVyVZe8NaWUIMr9A/S7Sp46dHaIr
	ztVYTdQ=
X-Received: by 2002:a05:7301:d194:b0:351:28eb:8cd8 with SMTP id 5a478bee46e88-3515ddee11cmr7825200eec.18.1791486073803;
        Thu, 08 Oct 2026 12:01:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>
Subject: [PATCH 6.6.y 0/2] asoc: backport CVE-2025-21870
Date: Thu,  8 Oct 2026 15:01:02 -0400
Message-ID: <20261008190108.96660-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21870. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. ASoC: SOF: topology: Parse DAI type token for dspless mode
  2. ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
