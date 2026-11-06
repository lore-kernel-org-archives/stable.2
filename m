Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926915;
	b=Dj25PZau3q+n1w95DEGlPAEAtRnoU4F62K2tnUEetin07ullKKmafSliQnSnyXDEOKrS
	 2CZPnBE+8hfIhdUvZN+p9C0AT86SBT6aNHeF2sGl9VVIVD6ew1Yfa1iOs+49XRHN2LnZd
	 OaHA7Ycwmk/A1akd/YD9hKNhKCcmq+cmCdoJwLqYMFq+3jiHffuCk6wla3o5+/MiOcxLl
	 mt9yI2JfEQ4uWJ2UmnLRrPPlw4gqOtbcMwaGyfTShrb3YOIWttXxnzIjde1bpcuAdIzuJ
	 UC5Hk6X3tPWV2ne8PpS1EXzQCFjLqHEO9+oQyhGxUoaLd+7M0fGLyUH8O7PdPSc8dxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926915;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JR9xevba4i54Awkgm4egESxQPW7/uL65vbMwOQhl3c4=;
	b=i/JEF4CHSBGaw+R03XCxRZWi816yQ38NYZbEXzfaa9xy+S8OEJv84gwUlwDkIdqM5Ax3
	 EEqSdxHCE7CgFrHVEBLMa8n+3NozH+k+PrZcn2JPbQj6O8Bxx931bFL/c/TLPLMlvFWKd
	 pebyhrvUDklzmpcPz8EiRfLeDBgJ5DP76XYgocCUo3dN7tZrwsFU7Pd5AnoxmTYivxihl
	 mvQB+POHaes0NwKL/cD+SOLtYV7ctfCLPkhfbxpN03bHqcSenYI7hTOiV8Hr2f4DKda4b
	 kQzxxDl0NCSvR3mJ1ftC3N2TYSOCkXFfeML3YqPYOyDyb6VRrboPE/bNy/lTu3q/4dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="0Bmw/yCZ";
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C1606A326;
	Fri,  6 Nov 2026 01:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=0Bmw/yCZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=0Bmw/yCZpo0z4doei3WPGYukYqS38O0V1aIF7RcLS6apwq3GjfIrATFLpvJN2VM1vKjRX4nalutW7
	 0RsKoOBQx0ggaa83tv1DP1GyovEML+KRRFhTHYp8tW+wNOqyy5+qkwJMcIiZstJthVhHBHp4N/0X0y
	 5wsDTkahRlLixtB8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aed26f6b0f-75f13;
	Fri, 06 Nov 2026 09:01:44 +0800 (CST)
X-RM-TRANSID:2ee36aed26f6b0f-75f13
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6aed26f4e82-0af84;
	Fri, 06 Nov 2026 09:01:44 +0800 (CST)
X-RM-TRANSID:2eea6aed26f4e82-0af84
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: cs42l43: leak MCLK when PLL enable fails on PRE_PMU
Date: Fri,  6 Nov 2026 09:01:40 +0800
Message-ID: <20261106010141.1772-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <ausROjYJJ2af1kXj@opensource.cirrus.com>
References: <ausROjYJJ2af1kXj@opensource.cirrus.com>
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

Hi Charles,

Thanks for the review and pointing this out. 

On Wed, Nov 04, 2026 at 11:04:26AM +0000, Charles Keepax wrote:
> Could you point to the relevant bits of the core code here? My
> understanding is that DAPM mostly just carrys on in the case of
> an error from an event handler, so I would not expect the
> sequence to play out as you describe.

You are absolutely right. I dug into dapm_seq_check_event() in soc-dapm.c. 
As you noted, if the event handler returns an error, DAPM only logs it 
(via dev_err) but continues the power-up sequence. 

Therefore, the widget is still marked as powered, and the matching POST_PMD 
will indeed run and execute clk_disable_unprepare(mclk) as expected. There 
is no reference count leak here.

My initial premise was incorrect. Please drop this patch.

Best regards,
Tang Bin


