Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630217;
	b=TxyJXnXbcFtoXkKKorEWT94es7MeD2xvc5/lDEqylIFiS9F52lCwGdBuyodV8RGKxDHh
	 SKDhrW9RFI92fkvu8AZfMY5wXvShEf5TbCloPhk/h5tIdcfHdttvdf2CVYihik5/5ftxU
	 zMXbTwW/dSAERZni4Lp9KjwcrlSf0uNv5s/tO/qQjhY+TJ8/1a8eDbR1Klto2vRoPxn+R
	 ZtMxFwYgH87zhFdU+0XbglBzHEyPVapp/5PZsn+TwfX6FJP7VB5hiEPvCDxpvf7btr9jw
	 67QFw5Q81Ng+cZ3ELoTqXwKxfQHpsd2r4BB4kugfms860HdB2gkzZnoqHlO+Gcso/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D3ALQHcgOfAhUAKhVbZdjihQ4c8Hm2EiPI8oXAafIGM=;
	b=4GH5pdbFlBq4jrT9JEfA5/vKfC+sNd5/HFS6lwvapXmsdkXe1PDncoSbwNPA7QOUr3nt
	 8zUYLbeI8YoqtIq/OyqEyytY0W3hq/rS51HoxWbPaGVf65TSwUJOdgE442Az0Vj3XQpX7
	 KILjuwlwTyTTyAzWW8fuxy/lKJhGSve4JsU8fWz5ZhbVRd+sLyE++h8FazUrXPwRi1v+G
	 +2T2G9NeTUU41MzjxXVVWuZXFTJYTF4bfb1GMyJ7pe3HNMdXVTgReKG98VZt7/XAqMHzI
	 PZaaBvZQ3ZQ3zf5rEFKEtE5+Vm9oPAx/8IdHOcM2gx5N3ewK/dKwpOi8EH5/CF21bzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="YdXtTz/v";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D9606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377D9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=YdXtTz/v
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db0791748so7079634d50.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795630216; x=1796235016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3ALQHcgOfAhUAKhVbZdjihQ4c8Hm2EiPI8oXAafIGM=;
        b=YdXtTz/v6Nm4qzgVyt4tU1Dm9vGEsroperK4W3BGilBnyGrVMOM6MIT5XJD2rcDogB
         AWuqcPc7rOYnD9e+HpsWAPKiW9DYo6OEiOtdmUiLKvIuxOHtWDuJHlD/vCKafPsJxQLC
         BXllwZhuRD1IwujoB6aBtVMXSWBjO++oCGjBlQYfo24feoz8A4QtCZhzrClzWJOySJkX
         +xT/ureqEuqX7lIeo6TLrqv1qZbU8hEhJweFrf0dfdpjPJpNItgT6YU6OW4VThEXW6+m
         cm09thM45wrjt173UXANGAdABSORsn4HM3CBs7dMDTus+al+tGpQ23jXx/OE/f0h4gvn
         cJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630216; x=1796235016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3ALQHcgOfAhUAKhVbZdjihQ4c8Hm2EiPI8oXAafIGM=;
        b=LvoXzYrMnFJ8gZkai5Ls3GNeBbMRnX4OGQ5YRO/HlLxyniKSIp9/vpKRtTpVZDWqpC
         srdFNlFkU9mbOPSDfloxTBBgzAUAHhARbWrU7SznSLSqaEpGBammNWWB3gB7FH0iew0N
         4T6fdOu3V9Z6IDh+TfMslzI5sLzyKOa15fab2n913zCR/p/zcg0+ZJAc3lsAFqHxw+53
         l3/rfpi3tHun6Ta+Sg9M2oHMFvkF22y08MsEhb9Y3FBp0W//WA53Jw+2V/AA0RmOdVjg
         O/ImuZBRMWyatm32KwceI45I2FPSYvnD1cf/dc+LZ91f7FIzq/PFZd9V3GaozW+GUyI6
         MS6w==
X-Forwarded-Encrypted: i=1; AL+hErFnFwcfkHNNF8b4K1JGRnIjMpDtDkEV+WaxghlDpjg6xO9NytygcQgDLOshVr6eMfdKxW4bgWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OU5bAGYzplQN8JQqnmLKrR432z+njTDxa4Q/a834i0sHRxsIb
	4V2bjjBRKypnStN7C0NqCCxwI3b3cf8AA+YI21QXBaF7cJ21fvV0pN071RR1mA/YMg==
X-Gm-Gg: AZFdTZcSv+i1gq3dN3Jk5RsZt/8irD5T2wlyaeC8YhSE/KWy1ZAgr2VR9n7ZCVpBIib
	sDOQ7fX6xVizv0pS7MiU32BkA7ugrTRH01qk3k1vPI2WpZ2v/LL5Qd8vFET6G5g1C2Qh5kpu+PI
	ZkXXuhBAHv+BiEjf0UXkahtKqZlscFRei2VXx9HwpnzGvQz0XdA1PktNNnEveivCcUAx5y3kSou
	AQyhqDDkHaM1qdr69wJf+GQhD2pvgsAsDHsYAGS6oGbjizDvyiOJE/olfBrAjSC/K5T7Pf2nYkg
	g7N6UhAUKQ6JVhJfwQGFSH1oxputKCfSoSe6QcbHfPEjeouUmGgNcUlHDjE+0QapmhJTULSKtWV
	10wYL3MQ8l/lyxom8TISvKr8UU80lfaZscmpSxfd9Ylx4uh5U4Ul0t4PxZNlSRpPeWvgYZMLram
	Jn2+qV4zQCD0sg8L4MeyXvPxlb3E2D0chPI4FaENuhy6+L0USl7Qui/yEC0vDTsr3+zvPa7WYjI
	eQdy5iRzltom3u+hgBTR7nMPY0cCXCEy4PAJNBz/oNZXFi2V/WNYnXX+6BcSy7d1dSp52i7Ip97
	8r7JHCpueoBqbuvMMGFEdTe1ZOrgmQSEMwKRhKb7YfgxcAf6wRoy6Q==
X-Received: by 2002:a05:690e:400a:b0:67e:4934:63dd with SMTP id 956f58d0204a3-67e49347cb2mr1238903d50.15.1795630216103;
        Wed, 25 Nov 2026 10:10:16 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df330bfb1sm9206152d50.6.2026.11.25.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:10:15 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: pcm: oss: Refine slave hw_params after setting format
Date: Wed, 25 Nov 2026 13:10:05 -0500
Message-ID: <20261125181005.3683575-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 93d7d38fa61d ("ALSA: aloop: add DSD formats") added DSD_U8 to
the formats of snd-aloop. Before that, its narrowest format had 16 bits.

However, snd_pcm_oss_change_params_locked() sets the slave format with
_snd_pcm_hw_param_set(), which does not refine the parameters, while
the access, rate and channels before it are set with refining helpers.
snd_pcm_oss_period_size() then reads a buffer size maximum that is
still computed for the narrowest format, now DSD_U8, so the OSS period
doubles. With the default U8 client format, the doubled period no
longer fits in the format plugin, and snd_pcm_plugin_alloc() returns
-ENOMEM. As of now, an OSS program that asks snd-aloop for 8 channels
at 192 kHz gets ENOMEM from SNDCTL_DSP_SPEED and from every later
ioctl on the same file.

The issue can be reproduced with this program, where card 1 is
snd-aloop:

    #include <fcntl.h>
    #include <stdio.h>
    #include <sys/ioctl.h>
    #include <sys/soundcard.h>

    int main(void)
    {
            int fd = open("/dev/dsp1", O_WRONLY | O_NONBLOCK);
            int ch = 8, rate = 192000, blk = 0;

            ioctl(fd, SNDCTL_DSP_CHANNELS, &ch);
            if (ioctl(fd, SNDCTL_DSP_SPEED, &rate) < 0)
                    perror("SNDCTL_DSP_SPEED");
            if (ioctl(fd, SNDCTL_DSP_GETBLKSIZE, &blk) < 0)
                    perror("SNDCTL_DSP_GETBLKSIZE");
            printf("block size %d\n", blk);
            return 0;
    }

Before that commit, it prints "block size 65536". After that commit,
the result is:

    SNDCTL_DSP_SPEED: Cannot allocate memory
    SNDCTL_DSP_GETBLKSIZE: Cannot allocate memory
    block size 0

This patch will set the format with snd_pcm_hw_param_set(), which
refines the parameters, as is done for the channels just before.

Fixes: 93d7d38fa61d ("ALSA: aloop: add DSD formats")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

The missing refine is older than that commit, so the patch also halves
the default fragment size on other cards that offer a format narrower
than the one in use. On snd-dummy (U8 and S16_LE) with S16_LE, one
channel at 48 kHz now gets 4096 bytes instead of 8192.

With "ALSA: pcm: oss: Compare max buffer size in bytes" in for-next,
the program above no longer fails, but it prints "block size 131072"
until this patch is applied.

Tested on for-linus (5a6fcabe156e) and for-next (486060b97284) with
KASAN and lockdep. On snd-aloop, a grid of 1 to 128 channels at 8 to
192 kHz gives the same results as before that commit, and SETFRAGMENT,
mmap and a playback and capture pair work as before.

 sound/core/oss/pcm_oss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 66162caa45d4..3c2ac8966d5e 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -921,7 +921,8 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 		goto failure;
 	}
  format_found:
-	err = _snd_pcm_hw_param_set(sparams, SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
+	err = snd_pcm_hw_param_set(substream, sparams,
+				   SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
 	if (err < 0)
 		goto failure;
 

base-commit: 5a6fcabe156e91c6ef2435a74f2d16e6dd39f7c7
-- 
2.53.0

