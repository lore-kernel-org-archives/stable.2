Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE648A2DF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440273; cv=none; b=dHA4kKmydtei9GK6Qj+Id/jIBlcB2N0V1XMPb2U9DpduQHMSiYKRsfcI3ByRPIgbgVjXJc3tjv7BPqzxW+MFz/3dQrt+7teDcUEpW0WObGoj9k7M3scaFYWuw5c2Kg04l+DZBhSSutJINAOF8VWCiDYAT2hOyfKp8h4l0xBc7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440273; c=relaxed/simple;
	bh=PiqC4JuMN4P2cFd/qh4yCNEWknfB3j29/4moC6Idl4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZttGFq05s/gzt6fxbx5UROVaQnFG1Mxrd3eNhpeDeWBDCdY1PzIUr6/9ei9EaEHrdeN1AQ8jK8luEsDRbE6A8m4quDhdawBoTPWEMcpZUPJDyuu/FBdiNzatiMByQNo3RZW63R47xh2ZkfOBJWOXyMGfKqtBKUS0/AD+LpdbzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgKGLUom; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgKGLUom"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so21187275e9.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440270; x=1789045070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXLhIfYsLXeb4uBk9/T4YBgTRm5mlBNtoFfisfwQ+IU=;
        b=dgKGLUom/iPcQcWWvmRffwzsKxN0owOir9NnoDREQapv3jLe/7bT5rHawBmuYkdDCI
         bVRi8A7e6K0Zic9fw7EhGMTQkOVMl25Sc1d+exq3oSi+uotJb1xh1VkHTv9MWQyuqAiB
         4j4imFmBKNgPwAS5xnF6aSYI9PFkzj/JcgCkNexwpYND2dEw+lnpx4nxwej1jkjXrbND
         5miZXU3h8SATBISDmiS+GhebCSZXpJTDC0mQzzAg9fNHT0M86spcmu5u9GdcKS5AnfCY
         hqdLJrjc2wnK/QZFx1ZiAxsKoUz2LwG6mT9YtPePKXamD5pR1uea5JCqFzLHH02EI29f
         ZKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440270; x=1789045070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXLhIfYsLXeb4uBk9/T4YBgTRm5mlBNtoFfisfwQ+IU=;
        b=rJBRJScpwyiEJepEwssz38XttRdguEKz6NRRZbq9OirGIGnJU1H2Q/vjcdzIaJBivK
         eWfT2tcq3e9926gwzuamLW4OW6iQ7lmXTtcad/dga/SLo2u47Ch0fjWrXPX3mryUNwJp
         OH9RQgA+vYOelBsMEPveDhM0vOXzcKFEuwCHY5OsTq5UbhJeqv1wvTI7UjTanPBy52IR
         TRtoMzj4ZlBmBlrrgAcT0v3Bp6bEhvCamDcezQc3Bct2sk5irdL1l0ZlMECWwn3vxbn/
         oGZvhIGiCO4VxVgYrInxro1FujgmLhH2xBFBbkDPW3KhtyCXPRrxaPfn5DBsXxxuNKlj
         8dLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH/e4XaiI8U5+ZagobzTeZGuhlN5sFvmsH//F/RIm0M6fQrYAH2OzZWsbqKJQYxogT4ciueUg=@vger.kernel.org
X-Gm-Message-State: AFuF++kODPsKhHgIRhBmkg4S70PyRIl9nGw0T1SGaSLcGHgBKrXmcuD7
	c4BZXqlrjGoJfdFCuEyESzMfybCHkyPpQAD/smhZEpZsTjWdnBBvNa8=
X-Gm-Gg: AYBFou12XP67UIo1OzOhaFrzwtx0ffO8lPq/tOziAP9/x9NCX2Lvmz8lNrLZwb38aKX
	xVgkzsE1cuEkqyI+dmsvzr1SU1RMKFcgabskXo0DAXVNZ2FtoAHpEX9lN5FxgqURj+76qVoChYh
	DswSGviwZQXW5fOig9aCBjT0KkR8wiHQE4iG4DI11tPQMdKjjFS1DaLIWF+YYSNl47ev45S6OQr
	0ettwA7vK9PPo2M9rAdkJTBcNaXa5GXKw5KPQqpC5b4eLUNasoW53a3e1s1bOQPk5gTfCjttlqs
	PzrFRxIVnRoK4LmCDFfmxLHtjHpTOJ/GGH8fGrNlQhjLTEE+m/jzvckEDpIh5CXBhzokXlTzcpA
	sjQPJRLfFPSxbnUjwjGDo3W7gG3I4jN5hR1P+zGrHpITw9yTnkTX9btYrRDIE6VLyjK9KipkMix
	HHFX1R0aHh8hv1XntcQxnOmXBRe+XDDSsMlfBunWuDwGL/q6Z5sbCNEPaMRUkmgaJTbCoeWcafr
	tRFHYZKCWtapWMoVGnrBjkpeYmPWaxZrhLBRzRJN1sz
X-Received: by 2002:a05:600c:8b05:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49ce5823d9dmr261274455e9.11.1788440269473;
        Thu, 03 Sep 2026 05:57:49 -0700 (PDT)
Received: from surface.. (84.124.213.91.dyn.user.ono.com. [84.124.213.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf0c1728bsm55404005e9.15.2026.09.03.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:57:48 -0700 (PDT)
From: "D. Manresa" <dmanresa@gmail.com>
To: Jakob Berg Jespersen <dev@berg.pm>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kevin Lhopital <kevin.lhopital@bootlin.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Fernando Rimoli <fernandorimoli11@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"D . Manresa" <dmanresa@gmail.com>
Subject: Re: [PATCH v2 2/2] media: i2c: ov5693: fix horizontal flip polarity and Bayer phase
Date: Thu,  3 Sep 2026 14:57:47 +0200
Message-ID: <20260903125747.267745-1-dmanresa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <nCjqoWI6z141hFVhaIJmJKK83OIBg5hmB1uE_5U_sqbA0B_kIEPUmVzPTuOViWOyT0y-dCy5yDo2BpGGXWO99LeEugNunoW0eVooQGFMxrw=@berg.pm>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm> <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm> <20260828231805.29790-1-dmanresa@gmail.com> <nCjqoWI6z141hFVhaIJmJKK83OIBg5hmB1uE_5U_sqbA0B_kIEPUmVzPTuOViWOyT0y-dCy5yDo2BpGGXWO99LeEugNunoW0eVooQGFMxrw=@berg.pm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Resent to the list at Jakob's request: the original, sent 29 Aug, reached
him alone - a mail tooling error on my side that dropped the Cc headers on
several replies that week, since fixed. Content unchanged. Jakob: yes, it
was always meant for the record - thanks for checking before quoting it.]

On Sat, 29 Aug 2026, Jakob Berg Jespersen wrote:
> One oddity I cannot explain: the vertical flip moves the phase by a
> column, not a row. [...] I report it as measured; I have no mechanism to
> offer for it.

I think I have the mechanism. All eight of your full-resolution states
reproduce here exactly - same phases, same two states that will not stream -
so this is a second unit agreeing with you, and then some extra measurements
that localise the column shift to one register bit.

Same setup as before: OV5693 at 2-0036 behind an IPU6, raw SBGGR10 off the
CSI-2 receiver, no ISP, no test pattern, registers written over i2c while
streaming, 40-frame captures.

1) The VFLIP output is a *pure* vertical mirror. Correlating each state
   against the reference frame and against its h-flipped, v-flipped and
   180-rotated copies (on 2x2-block means, so the metric is phase-blind)
   gives, for 0x3820=0x42 with the FLIP_HORZ bits set: vflip 0.996 against
   hflip 0.182. Nothing horizontal is being mirrored, so the column shift is
   not a hidden mirror.

2) The row phase does not move, and that part is correct behaviour. At
   VFLIP=0 the phase is GBRG, so row 0 is G B G B; at VFLIP=1 it is BGGR, so
   row 0 is B G B G. Both are the blue row: the sensor's one-row
   Bayer-preserving compensation is present and works. Only the column phase
   moves.

3) The sensor does not expose the shift. Reading 0x3800..0x3821 back in every
   state: CROP_START_X = 0x0010, CROP_START_Y = 0x0006, CROP_END_X = 0x0a30,
   CROP_END_Y = 0x079e, OFFSET_Y = 0, unchanged throughout.

4) Splitting 0x3820 into its two bits is what localises it. The driver writes
   FLIP_VERT_ISP_EN (bit 6) and FLIP_VERT_SENSOR_EN (bit 1) together; taken
   apart, at 0x3821=0x1e, offset 0:

     0x3820 = 0x40 (ISP bit alone):    no flip at all, phase unchanged (GBRG),
                                       image registers at (0,0) against the
                                       reference. A complete no-op on its own.
     0x3820 = 0x02 (sensor bit alone): flips the picture (vflip corr 0.997),
                                       and does NOT move the column phase -
                                       but the colour path then delivers R and
                                       B at the noise floor: plane means
                                       18.6 / 18.4, std 8.5, against 175 / 173
                                       and std 251 for the two green planes.
                                       Unusable alone.
     0x3820 = 0x42 (both):             flips, R and B are restored, and the
                                       column phase has moved (BGGR).

   So the ISP-side flip bit is the one that both rescues R/B and carries the
   spurious column shift. It behaves like the internal pipeline being told the
   mosaic moved, and moving it one column too far.

5) It really is a one-column window move, and it composes with one as an XOR.
   Calibrated against a known one-column change, at 2592x1944:

     FLIP_HORZ set (0x3821=0x1e), OFFSET_START_X=0:
       CROP_START_X 16:  VFLIP=0 GBRG    VFLIP=1 BGGR
       CROP_START_X 15:  VFLIP=0 BGGR    VFLIP=1 GBRG

     FLIP_HORZ cleared (0x3821=0x18), CROP_START_X=16:
       OFFSET_START_X 0: VFLIP=0 BGGR    VFLIP=1 GBRG
       OFFSET_START_X 1: VFLIP=0 GBRG    VFLIP=1 BGGR

   Pixel registration agrees: a per-colour-class-normalised, high-passed,
   15-frame-averaged correlation gives an envelope centre of -1.15 px for a
   deliberate CROP_START_X 16->15 move, -0.90 px for VFLIP, and 0.00 px for
   the self-comparison. Same signature, same magnitude, same sign.

Two by-products that bear on how a v3 could be written:

- Your two non-streaming states are a plain window overrun, not a flip
  interaction: CROP_END_X - CROP_START_X = 2608 - 16 = 2592, exactly the
  output width, so OFFSET_START_X=1 runs off the end. With CROP_START_X=15,
  the state 0x3820=0x42 / 0x3821=0x1e / OFFSET_START_X=1 streams cleanly here
  (40 frames) and decodes BGGR. Symmetrically, CROP_START_X=17 with
  OFFSET_START_X=0 stalls. So the state you needed is reachable after all -
  through the crop window rather than the ISP offset.

- With the FLIP_HORZ bits cleared, CROP_START_X has no effect on the phase at
  all (the window appears to be anchored at CROP_END_X in the mirrored
  readout); there, OFFSET_START_X is the knob that works. With the bits set it
  is the other way round. Any compensation therefore has to pick its register
  according to the horizontal state.

Measured combinations that give a clean BGGR at 2592x1944 on this unit:

    VFLIP=0, 0x3821=0x1e, CROP_START_X=15, OFFSET_START_X=0
    VFLIP=0, 0x3821=0x18, CROP_START_X=16, OFFSET_START_X=0
    VFLIP=1, 0x3821=0x1e, CROP_START_X=16, OFFSET_START_X=0
    VFLIP=1, 0x3821=0x18, CROP_START_X=16, OFFSET_START_X=1

On your plan: reporting the media bus code as a function of both flip
controls, with V4L2_CTRL_FLAG_MODIFY_LAYOUT, and inverting the polarity only
after that, sounds right to me, and matches what the numbers above say - the
phase is a function of both flips, so no HFLIP-keyed compensation can be
correct in both vertical states. It also has the advantage of not needing the
sensor to do anything it does not want to do. If you would rather compensate
than report, the tables above say it is possible, but it needs both flips as
inputs and a different register in each horizontal state, which is a lot of
machinery next to just telling userspace the truth.

For whatever it is worth downstream: my out-of-tree binned mode is unaffected
either way, since it keys its window offset on the mode rather than on the
flip controls.

Happy to test a v3, and to re-run any of the above on request - the harness is
a loop of i2c writes plus raw captures, so extra states are cheap.

D. Manresa <dmanresa@gmail.com>
