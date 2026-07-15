Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979B3CBE8B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149107; cv=none; b=o1LoF/JStb2s95vu0zUJkj4vcGVdjFvd43Ia3d0tNRlJ8w5YzVFTmFike+va0QrI0QjO96X3xQv4FMmlou9lHtb6oMY4kGWvnVE47AnK3EwFEXdzYpECAL3+LQrUfrQTBDBdLcq+RsdZVU4G4Ky1wjevfZcy3LS7xu+CkJP87s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149107; c=relaxed/simple;
	bh=aKwNcVwe8k6l1xte5Jc29BllQmYsaGkbBJF3XYL1a00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ1DUoxNwjayltbzu2c8R44S/K0SXtCSBrW1lg35gx8BjzyW8Dwo8EBueHnohGfIfhy6iykOuhFCklKo3WXRBzfle6tOPplB5u6ZPEkB7CC/utTAK2EEp7J4BHaHWy5R8IGbg4TFA+Qjz0IoTI3qDtFddMn26K8kfQDzt+2lbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU+7i/6y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU+7i/6y"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so5573463a91.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149105; x=1784753905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuPUQonPFmI0rFkgA1ueaWLbPCDRn98daoQtVv6yMEY=;
        b=DU+7i/6yZ4spxBLeIW9UM0D3HfnIhN9+g8EnxAM0SA+14aBImAxNB+CnS+Lg4biJj9
         9w3/dgOka/V32yWj9Q6M5H2/fVWr/F234wmzgGRZo2Yxi3rguWEfZK0CV20FqOExrW9E
         LTf3A9o8bJrPhEzAkAfQVibdI0EvPATTqPme8gaD151yE/PbZk3SoCDRUBP0FJ78vSbi
         oI1PbQOMkaVq+3q9HTn9GxiYDihYpRlbDdOCarBzBSsssh9x3/To0TmLf+79+8/HS5MI
         7yfea2BQ3psh1FyzpV/t66dGlis7R1c706+1BOocLpKxo0lwuR/oetXXTsPV3Kbc3Xyp
         6AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149105; x=1784753905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuPUQonPFmI0rFkgA1ueaWLbPCDRn98daoQtVv6yMEY=;
        b=YDpGgs9GCTQDnwWey4sqdMbw3+c6rMGDOmPIB23WwXLnO2O3CfkBcXHo4vyWTXEG6c
         xdwGv3tvU521rw1qivnFwknFp7vd/JgBlA8np7myFB/YfbafFJRxOQ7s7uAxDKdn4MJ9
         sAPBAu8SIsCjWcNmjb5iI/QxY/k3MrDx0nE4MjXPEKQrvDQb3Zwgm8kLTkdyP+U5KxrN
         SUDjiZ0QBq7OELjs/7/w5u3MAEY4JK5eDjp2QZ4gFdlDnFSCrrGcAp7wjd8ZFHRQU62r
         99q51Cjm+WfrM3sHoygE1tGSxwLksmmOBHinaYYR0LmWoC0uWjS7ulLoSz/6Ac9mCifs
         5p9A==
X-Forwarded-Encrypted: i=1; AHgh+RpULG83wcMY1K2opmIfhiUVbV/mm5reV9qMteCx7gyrBN+Hj0+FGh+N6lT/Xr+uDh4YTKcczAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9azDrM7mK2+EmzQkm8xCN5ai4ZVDc2A364u2vTl40g6NvQf+T
	XB1ooQUGII1tG56+W8/JWNpy0qkFSUOvAInabi+Mp3D7w1mM6b6BA63u
X-Gm-Gg: AfdE7ck/7JRokCdNy8RL9fMhV2H9ihf4ImfNeqg4oDCFiAu32TteAEQeXD8Lb4ydz0O
	C3wp6oeUan0Aifynb7wuxF1UHCH0OR++p89se+l0fGc5tNsin7Dp6rIvMLyab0M3BsPUyK5My+8
	71EGrEoMlG3dEv1N5ea6sBHbUL0K1+QhSzZ9XlJFD3FvBOKbmbBz+6sthc8PH2Xtn+djZb0telx
	RYJ18GNvzAs4sD0HXvTSb4r6/3JgbczyN+s/QzD6joKgl9gb/Nsv9l5w+zGk12OJZR4AbjLWgL6
	hNLcK1kcUX5xG2yxgs46WFWjO3MqgCN9ePviw9OzpUFEfNvgZ3UBOJWY6jbfPouOt3Ami2g4+A4
	skIXxvU1Da1eHR45fuHeDkfptgCCnIhp50KN0cgXI5faf58Ly96z/aTKdfkujXLS5UGnQVVLe4Y
	jTiOsfC0Es6mhuD9hX9nxO7sWewYubQnnCFVSj8AmDeG6lz943P+BfKCHPoFGvtoM=
X-Received: by 2002:a05:6a21:a98:b0:3c0:9c19:65a1 with SMTP id adf61e73a8af0-3c36c4571fdmr4362931637.73.1784149105146;
        Wed, 15 Jul 2026 13:58:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e538368sm7007333eec.12.2026.07.15.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 13:58:23 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:58:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: tca8418_keypad - enable overflow mode per
 datasheet (SCPS215G)
Message-ID: <alf0aY63QIPMo3jT@google.com>
References: <20260529013900.43854-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529013900.43854-1-liangzhan5dev@gmail.com>

On Fri, May 29, 2026 at 09:39:00AM +0800, Zhian Liang wrote:
> The driver currently sets only the overflow interrupt enable bit
> (OVR_FLOW_IEN) in the configuration register, leaving the overflow
> mode bit (OVR_FLOW_M) at its default value of 0.
> 
> According to the TCA8418 datasheet (SCPS215G, Section 8.6.4.1
> "Overflow Errata - Description"), both OVR_FLOW_M (Bit_5) and
> OVR_FLOW_IEN (Bit_3) must be set high for the overflow interrupt
> to be generated. If only OVR_FLOW_IEN is set, FIFO overflow events
> are silently lost without notifying the host.
> 
> Fix this by setting OVR_FLOW_M alongside OVR_FLOW_IEN in the
> configuration register.
> 
> Note: I do not have access to hardware to test this change.
> Testing by generating 11+ key events without reading the FIFO
> would be appreciated. Full handling of overflow events in the
> interrupt handler is left for future improvement.
> 
> Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>

Applied, thank you.

-- 
Dmitry
