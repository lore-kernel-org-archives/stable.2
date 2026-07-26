Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4208387359
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067060; cv=pass; b=Wuj1DY5ChhwxKhY7dc/ZjhqBUGP3zB3hvrl6//7bAS5eaKQ3VkL2d9vGfA683qAFkRSWGCiWRlFKATIRRSTan0vNxZJCa4XCfD6EkXlwsKwn+uY/InhfL25QESjZ1W3BNtGlXcID1FX0pZ9zDoB5XM+/EQoL2nMtXM4XrcZglkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067060; c=relaxed/simple;
	bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsav3w3c31E5DMk57AubHw1BL0do0d+F7Z7XF/LJSPATTDX110h8ILMcWUuyuqKE539W57JqPQAgrvXpV5cIkRNshuzYbkgEHUy7uyTQT+bv+D6TvaaMjEBOQF0+kwtvc534H5R/D4KKnUZ/cKfaXupHBZUIVrRwDnSvcmA4JL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDvSTT2y; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDvSTT2y"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aaf2f9ce3dso713479eaf.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785067058; cv=none;
        d=google.com; s=arc-20260327;
        b=UWF+yyz5mBNpXh0OFcEA+GUowIK1IuzQPZ4dt4ixge5s+gb6MP9l9gdyF2x2953vtu
         5WbdK0/TGb970SnfTPTlAWefqDjIODGUrUm3WR/kY3EVjFnju2C3cExS87/CdDGUe1RX
         C5QaUyXUxwRvifndePTWhI/LvC1cPSDAD1ev0m/ZJLKVdeLEi4j6LxotqpCWroKGm+kY
         mL2aj5LoSTgkOLM0OkGCLnciBuhCUUhojrK/F3dJp2d5MU7TSbIadbW4ut6ppQF1OKhH
         PdbjO7Sm4116RIaLWmPp4NUD4rsKElr8jDPfz5rHh+/tN2iyzdZFWQzXCzSRqcj63C00
         7MHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        fh=xtj07tUcqchrxeDopQX041T3k38nuX+9lj53XybvSQw=;
        b=fgcopbnD6qNYdnTxkT+VjE82lOvEb59xLyrtnHjoNxQZOQCl1L7+lgQgWtEoHc5bUv
         p7W871ovveI29fJcs2/4QlJSnMRvgNW5PnwhMSbMbugiF9sViwPIkrFuQ6MeelhD2pBC
         bht2pRr41jFb2v+zOimhC5tkFzy+uFE3OWrF8iEptkZioJt+Jd58Nhm9ucWQ9j8O1cRq
         opfhKgnBBdj62UV+u2J0C/MEXIlJhrreTzY/0ULian9bt2NXV4UQ09ltTO6L2wkG4xS0
         tS6bhGuD8Sx5djOLnX9G0si+L3iiJeBc8KzQK6WowMMQde/Gi+OEIZoGsx8MSDhHscU+
         Gvrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785067058; x=1785671858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        b=rDvSTT2yeRWqkxBJd0XMH0pm2xv3Jymtayb4IbRvDZMVQjfAICQIn4nSEoPpUv4s31
         KDDTyJ/e6xKD548Bkmve0adj5BXLnd0G72nLnKZNsUtxrbrOkYZXIqkfNClJ9SVbFNqP
         3aS928Qi4XqSjHF+F/Xk1yfklidMOHSxsBZLd7NMwDZdRkyh8KCwr3gDbbKti8iVq/MH
         oKQBCwT+YxYm1NAoZqZND2KS3oJI6ILTGnm4/9Laq0KAVjDf6W44v2+mvS+ua/hZHNnk
         vk3Vi7BEDI3ffUkvvJFK+CV9ZTKu0TElPFShf6fsD7KY95Ku2iAGPdVbUdnbUTaCdDKg
         Mz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785067058; x=1785671858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        b=h0QjMfAbwv+oD8YokWA/W0khPlxVnzAj7aJatu1VtMOG/Wuebn7/n/VeEKRni/IO40
         Y7X+Y9fFabAT0RL/jXF22tspl3B+HPegnWgaGgHSSUFlWL0XSZ/laE+xzJkdcjoo/wI4
         FEWlGkx2GXxhNRE5Dzjp/VzXuWNjP5GA7jupq3LIlT0FMYSLc1EJkPR+RW+fLGQMZ9FJ
         nI0ghnxTJw6ixJWw4tlSZGCUBkfk1qB3gbRfZdlvs/QH2qnjUHickYFZvwMfMMD8nLg2
         +j1E3RMNipTzKD+lgMC8LaqG2nSygw0OzM3NE4dcF0FMvj/4KmtHaf7dtbycjonlpPXS
         RXhg==
X-Forwarded-Encrypted: i=1; AHgh+RqJIvtU670pL038mwTlwCobjWwNLNWiUanA32KCbBGyMxNVRR/ZDSW/jvVvXfQrzjWu0R/h8es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPIKbLQ1MNfDK9nabZe/3YqMDf/9kKZrkg2aV5dC7Wg3hRfJL
	SsWEFJiP0oUo+oiT5T2njNzXdKk6dOmHRgiFCn6FY8U6HureM6GrZ8dIl4cM3c1y1OYeOJ8x3xq
	ecJgZVxxfqhLLw8eLhuRQ0lvpUPdyHZ0=
X-Gm-Gg: AR+sD10eC2WlycVAzavvbMdw6ZBSGvR8U6KDBk4vPwJJBKBYROXDjXlK9+5oO6te9Ky
	wf4A+NOP+AiRUqBdPqz3EUQWjU713I7LnFCiZSFwUF2I79Y3C3OExQQ3La837iZKFVmuajmGh+a
	ZaT68M+xzoqw5bL9rMqyv4b6+Pog/KMyMLsoQc2b+hlhG1KALDlsVAseI/iSY0rrEPutbfbBV4I
	LRkECJINEQtgelgTcugpwstw2ArW7ns64Kink50Uv0mmcdKT+DR7iyUO8rTiQ==
X-Received: by 2002:a05:6820:162a:b0:6aa:ed3a:7950 with SMTP id
 006d021491bc7-6aaffcd8e59mr3713938eaf.63.1785067057496; Sun, 26 Jul 2026
 04:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
 <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com> <amWPu_sGMCFJLN5E@google.com>
In-Reply-To: <amWPu_sGMCFJLN5E@google.com>
From: Zhan Liang <liangzhan5dev@gmail.com>
Date: Sun, 26 Jul 2026 19:57:27 +0800
X-Gm-Features: AUfX_mzyJWM2M0GDu15gCmekxQGQK1fXd1riPLyIJEsgr39ZEEJ3Il_NumYdgYo
Message-ID: <CACyTbM8kU53ZwjAA=2U8oBFd+uX3MGWyr-=cB9sSha521Uq3LA@mail.gmail.com>
Subject: Re: [PATCH v2] Input: tca8418_keypad - fix potential infinite loop
 and OOB access on invalid keycodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,
v3 was sent here:
https://lore.kernel.org/linux-input/20260726112658.37D911F00A3A@smtp.kernel.org/T/#t
It broke the thread because I forgot --in-reply-to. Sorry for the noise.
