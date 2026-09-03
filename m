Received: from outbound.st.icloud.com (st-2001g-snip4-4.eps.apple.com [57.103.76.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B54A5C3D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439059; cv=none; b=gq421LptnnCzehvoywXbe3pEmeREIC5ozmIJVIY7sGB+T+YqYnECR4SdsNdoteNSjCTAL5mPM6/Xtu4N6PMyxB5BKd/cWom3/U1uSlRVbxXbjtB/9uzY1PuF9AaJVTpyDSbmiCTxr+nubx8qz2QUZriPUqlbAT7cV9rhbaoxIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439059; c=relaxed/simple;
	bh=wm0MOd6pDp2tqG3+8qj7mVRZvzltRjZd88GuZCqO+dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlKFxJn5Sr9GWaNkuz37jNKBjsX3qQtgOEpsuvuD1gYotHo/DHFCkTOCldwtzPGGamH1KJw9uku6CZ60FjEd6e2xgrtB+9OCxSc+1SK3q+o/Xsk5ugLuKWe6gq8EieafGPHgrozRxnUAHkVbzmqrRxMgyHDCZaAtQg4tjMJDO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinon1.fr; spf=pass smtp.mailfrom=pinon1.fr; dkim=pass (2048-bit key) header.d=pinon1.fr header.i=@pinon1.fr header.b=DRKa6tEn; arc=none smtp.client-ip=57.103.76.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinon1.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinon1.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinon1.fr header.i=@pinon1.fr header.b="DRKa6tEn"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id 66A5918004F7;
	Thu, 03 Sep 2026 12:37:30 +0000 (UTC)
X-ICL-RepId: 01a06746-3b18-7bd8-a43f-db61f8a517df
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBKHVwPXxxBDUkdXA5eEhVdRUMEUhlAFXkIWgNYBQNeXwoTC1NWQhlXF11cGQ1AUEsbDlsXA1ccVkVcGEMJXQVXHB0eQ0VbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BHAlwfV0kdC0VLXxldRQ9fB1kEQABIAFwFWAVAD1YGWQRcA0EUSR4dXg5AAlw4QwRZBFxBFx5BUxcfSwBcRVAYRB9dHWYcXABWAlw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pinon1.fr; s=sig1; t=1788439054; x=1791031054; bh=c0crWePLkvwXPV5gJnHAhiIQYS12jq04QEv+NRyfO6M=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=DRKa6tEnXOifIx/mqWUtsBM0wGplRlIeljzLSEC4a32WShTlVP4VnbFPIf/M6JkegUp7swT/fKt9eOxPWzpq4Ya1lbLuJL73Wwbp8j9MCaDdalAsdcLlQzVHjH51BSZGhp5yGxRaMYjvnP/c6AnwaEkn4XWRhzx5BV6WDMOoHRC+Y+kbszl1lvL/nElBYG/c1GVFNvHrbD8t0SY3AZjLKkOH/hJF/AkskMDOXgC9jm2DrM0FG9dGyDiPV3nT+L+Adz0GmqRWHMLkK8C94Yhe265DuEJHooQcuYAHDmrNDGGrpeuhokGywiF1aHOcTYp+v0jSGqK9VmffkEOGkBfBwQ==
mail-alias-created-date: 1575045973000
Received: from 2a01cb06d02d74794b6d6271b4dfc9d3.ipv6.abo.wanadoo.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id 4B3B218004C9;
	Thu, 03 Sep 2026 12:37:27 +0000 (UTC)
From: Pierre Pinon <pierre@pinon1.fr>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Pierre Pinon <pierre@pinon1.fr>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
Date: Thu,  3 Sep 2026 14:37:00 +0200
Message-ID: <20260903123706.543711-1-pierre@pinon1.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
References: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ItCIq1ivjgRzbeViCwG5F-tvMnf4y8E0
X-Proofpoint-GUID: ItCIq1ivjgRzbeViCwG5F-tvMnf4y8E0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwOSBTYWx0ZWRfX8IaQWQ8Xc9cb
 mfvq42HfXVMG/bpMOEmibHn1p6/FMSZha5GolrOY7NMBQhI+CcTkfHU5kPBB0e+g/vU2uneyJSp
 8OVXNAGNcYplPDzNG27F3vOAo30ZikoGJntkKCJVaG0jUQQFMUn2QJo/Z4LAGV+QeITcboKWhXr
 ZDA0anw+0yDY1CfAf6wUGKcdTI5wWZNmei7Mq9hyQXpquuQf42/e0vZd8Bv47HelDdk+FVaxhTi
 FFNscvSqmoKlBHXphNC2pUm1V7E5vwF3RLjHz3hsSU414oCeK/NI5qZLMM/kzp6hmwpHSaNmJjQ
 6PeLcM5zXu0p/jlUq5Sfwiosw3Vq+eMWCPG4/XPQRgK9Klg4gJ22bjBDJKyQmY=
X-Authority-Info-Out: v=2.4 cv=Gp1PO01C c=1 sm=1 tr=0 ts=6a996a0c
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=IZRBV0DxEYK2dcOnbAcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABNf8H1Y4NnirWNPncQO7COkmrdRQtB3wXppql5PnMzJjY9F/MAluV3faudFK7k6yUUbQ8ZRZJdTA8M+IMTXaOkPx5Q+HbE4Tf+3jif5XvKybGaVqURIMC0Gog5kDIKFVpOV5f07kX7dumMeAD4qShalRCBNBaRl6w/osOHOS6qg02SJlJOUAX0yZEFhbgzpQDEFZGoMQCMblVBLWhnx48oX6K6MrPHgidt1TwiMqzkKqM//ONg36TaXeqEAftjYPyCwWV/JKYJw9Mp/ore+ZVAaXJUCJcbTWG7KT+tYJux77kMS6RV/zJJ7PyasM5WPU6g8sKV/6FGjPvx6d62kaFsdoERyQ9BNj34amU1VRmL/fHX++vvmDmdTwEF54fgifvxszin6RC0FrCfHybmRcVpKQKAYPKcgd0NjeMPhzxHuxPSow1+wLvb2/rYawi+jNJR2xjQhhwEBR0P4Yhh94xDHgEWRdM6znostUzTgU0MnGbUOdWimsKw0EeEkBOYDebrwVVzePSawMyW/0lsiB6hZNdLyaRMoWGzpyeIDkOE4WseDWh96RAysmYaZkbjtTFDPv5gs66oJsjxeiAtL1jpjnwOIhaEQkmM8lwMtF4Pq5ChhT4HqUPDypBmKj61JtmCWQtLs2YOASfsKDE5X7fNBggSQoNr/BwBSx8RtOnhttDW7GqX4YNhs3ZOR7evPx4nZWfE8afGKYeTVqEMpLj3akmEh835/TiM3kaKnE27oL/4WU1hcZq8vh4uX6TZHwSx9imeFWiAoefs4jbKG32/9+lCOlEL22AW30jzkcU2sDD8mlK2m2pmC05dpBbJDkuImizjqicpkgtLl/xqlofSAy6zCrYrQdojj/CCjoEDYHH8Ia/JOmKMymppxm6ybch1cHkqzQ2JBC+AH1opQ4+SfyW4LlcxF5h5KxnkzF1wU5ginUqA6P7jaTvN9Pduha9v/w2ZA5DGTDitP41UEoDbxU
 R+HvMA9zag4V9y8zN3fkajdDpr6rt8SfmkhmenFvavwV8TuPuoiNjV6byHriimL3LM56RmA6nOeCB4eGmXHdLph7kDpPuNGvNyWKuhNYT7gb5jBFS9N3Xn8hxfiv0ZBK26GEywOFIbcUh0Vwes7Lla3XZP5tcK0CVr/XLbsTPWnj8rBtfdZZyrg1An/MdcgvWSLfZdnk9waqRH5AduE37Ht2RApKdt4iSFWObeKgucnGkJqInC7GtI8+iGmwyZpP94s0J89K4s/vil/AQ2u1b65Scp9wrtEjGpM/QPHl15KE7pa6GLoXMLvDT/dVrsRYke/v4aWglWNen+PVZChWr3Z7K+orcDB/Y

On Fri, Jul 17, 2026 at 06:51:06PM +0300, Ville Syrjälä wrote:
> Apparently PTL+ no longer has the cd2x pipe select field in
> CDCLK_CTL. Take that into account during CDCLK sanitization.
>
> This currently triggers a spurious CDCLK sanitization during
> driver load on PTL+ which will causes a visible glitch on all
> active displays.

Tested on a Panther Lake laptop (Intel Graphics [8086:b090], xe driver,
internal eDP panel), Fedora 43.

For what it is worth, on this machine the symptom is more than a glitch:
the internal panel comes up corrupted on cold boot and stays corrupted
until a suspend/resume cycle. dmesg shows:

  xe 0000:00:02.0: [drm] Selective fetch area calculation failed in pipe A
  xe 0000:00:02.0: [drm] *ERROR* CPU pipe A FIFO underrun
  xe 0000:00:02.0: [drm] *ERROR* CPU pipe A FIFO underrun

Counting "CPU pipe A FIFO underrun" in dmesg across boots of the same
machine:

  6.17.1-300.fc43           unpatched   0   (unaffected)
  7.1.12-100.fc43           unpatched   2
  7.1.12 + this patch [*]   patched     0   (4 boots)
  7.1.13-100.fc43           unpatched   2
  7.3.0-rc1 + this patch    patched     0

  [*] 7.1.x predates bxt_cdclk_cd2x_pipe_mask() and needs a slightly
      different form, see below; the 7.3.0-rc1 build carries this patch
      as posted, unmodified.

With the patch the panel comes up clean from cold boot and the underruns
are gone.

Tested-by: Pierre Pinon <pierre@pinon1.fr>

This covers 1/2 only; I have not tested 2/2.

Note the "Selective fetch area calculation failed in pipe A" drm_info_once
is still printed with the patch applied. As far as I can tell that one is
unrelated -- it is the deliberate full-update fallback in
intel_psr2_sel_fetch_update() -- and harmless here.

I realise this is already committed, so the tag may well arrive too late
to be folded in. I am sending it anyway as a data point for the stable
backport, which is the part that matters to me here: neither 7.1.y nor
7.2.y carries the fix yet.

On 7.1.y the change does not apply as posted, since that tree predates
bxt_cdclk_cd2x_pipe_mask(). The form I have been running there guards the
two original lines instead:

	if (DISPLAY_VER(display) < 30) {
		cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
	}

That is the variant covered by the four 7.1.12 boots above. The same form
was posted independently by Chang Jiong as
<20260816062344.796615-1-xspeed1989@gmail.com>, which I only noticed
afterwards.
