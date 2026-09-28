Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB8377ECA
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571089; cv=none; b=E7hBzjxO/eX0CLDUE8SNh/Q1mjc9LnEcvBEQjCuwiKzwoTGTddiZqFcb4LtCTRqvYpLYfJmFCKTo/Qv+Lc+nADfHywDCrszCixrJCGQ5Q9QFttotp+NReZ1OdmIeAH/9W9d6U7jiHJtof5TyZN0kqnLNUTmXmmvfc3ZL9I/0Pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571089; c=relaxed/simple;
	bh=/RiLw2SErvUKqOgeJzpySOUxPAqr2XROBbtgzqBp1HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWuJG5Hp5KmJx8m+FUn6JKml7/x/zBwJIpr3MO9cD3rc9nTvyEB9NOsHpQpgo8i0aJKiwEbY4JSrBcLjgk7vTBXeJbqouEtjPUdHPK6mc2PIUxzY7Z2QYRjlaNQv+BdhhsBAvHFsXNBaA6fqXyZbOuellrZ7VTCIH8wu6V984K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7ccztPx; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7ccztPx"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so3759111eec.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 21:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790571087; x=1791175887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxBVsadU3CapuSwF1ZwYMR5BhuIaCuGr5O6zle7Zy+0=;
        b=o7ccztPxpxzhKsryUU5W3ki29pXPltPeaqr7hj1j6KqXGcLvALnP0J8kbzDYwDVw/a
         XEgl3Hu37uW8e9r87QEM7N2pRr33Fanvwk2j6kw9YqPjLHWIqZ2QEkrSPa44mMr6v9ms
         Hv2K+bJYOEQiNl/fr5AgpqGCD8m1sKPHF/Uzd2IF5h19Po0wnhQf8dJsQNjnTckDOMX5
         qqUrjif4ryPR1gfsrk3qLyR+U/k+9IMahMkzQav8kuBBn3zIjwYHOBk/VXh9xRchJ77T
         1/1Cue8wGD6DeSrcvV7R034lH9uViAVHLMhgwHkcZNTDbqiVJ8gxva10lAXFI4UIghKX
         6SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790571087; x=1791175887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fxBVsadU3CapuSwF1ZwYMR5BhuIaCuGr5O6zle7Zy+0=;
        b=ugO+owV48qc1mlizwGk9lPu0sWEkLxqdEgCRm0dt53vO43jR8VuKDz+Bn7OAIdlDxy
         a9yEJypXjaqzzTr6wIYD+n6JyiSj14w2buCxQ0OPBB4tEjwTLN1mzMAJJymQ2cNQAyAF
         gB1Xb+v5qF7wSkYrrrr33z3fyzcSkg7R/vgrkQRgtJ24CjSe//1IIkp03MxbDk2HAWVR
         aqPRhnHLy9GBV0JHTBSAZ0eCkPnrIDfnRoXSUN/7h5zVzxY5xMnlppVkyVcaFAos5ODs
         ntPr8gcalIim2PMUOu9Vf3CMIGxQpEbtuoYSgDcuiiWlwA4dy17f98VRLr18TZBpCrYM
         1Xhw==
X-Forwarded-Encrypted: i=1; AKwUvBx4XqNNmPYDyTQ6mp8/pmQj0se0JqzoZoMPMz8oQ9bRXzJWC3ke787IsCYuHBSAUFcUkhSO3Co=@vger.kernel.org
X-Gm-Message-State: AFuF++mLpesMxTxn4hkha8gtC9XfyQ2c6c03XaznAXEnKb0GEZ0jAHoF
	UBRyKMibv/xoGMzpQTNpRa1uWrd0Mx8plU/EdITrqeBWmX64PXnBgMf4
X-Gm-Gg: AYBFou3ItyizroeRi5E6IIZVPKxU/pDVqKLB9Ush0HKxulijPbHSwOIAidWMTHjaLkG
	DBw5IiL2sp4BnyZQg88jJKEqom+9Qgqk+jgRr5rn5OTEP6bkO6MaROJMudlatJqHdkl6bWaZmuf
	682g6Ga5/nm2MS7B8h03WnCYyY/zCtsmK/2I6yAa7tu6TtQymJd6R3SIxJ8iCR3SzCsWTF0z0qC
	kQrOCf6nS02tQJW6yEwr/cyxHleku/6Hb3/zeY0nHNToSO7wvRK5pAvkTJCBdr9kA8HltS1NUmX
	821vtuZYe4hQvV9rwvYPI4UtCveGMwIl49KD/oyzclK81GmBTHyXxGaVHofub1/jQAAogZqqoP1
	HN+IY1qZOHa6zd+9fgUJZji4pJ/aeegtu/DjZOGfzeUPGsmZNKdpD4GAeXMMApT5D9X1sPcyJim
	HllaLKjd00BDqi3apP4Bhglh3VzwEMpoHHqReRvWOi2pk6H3jLxd7HZx0Dxg1ti0wFeQ4wAfTGD
	fnsFFs/qa5aqmc2MTxB8QoRPmqsjne78OTw7sEN
X-Received: by 2002:a05:7301:4201:b0:33b:ea8c:811b with SMTP id 5a478bee46e88-3426fbbeb5dmr8469221eec.5.1790571086738;
        Sun, 27 Sep 2026 21:51:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22840869eec.28.2026.09.27.21.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:51:26 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:51:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, salmundani@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - limit T440p InterTouch quirk to
 LEN0036
Message-ID: <arnyJnqIpwcwX2nT@google.com>
References: <20260927005810.85971-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927005810.85971-1-rlarocque@disroot.org>

On Sat, Sep 26, 2026 at 08:58:10PM -0400, R. Larocque wrote:
> From: "Raphaël Larocque" <rlarocque@disroot.org>
> 
> The ThinkPad L440 also uses board id 2722, but does not have the SMBus
> initialization problem seen on the T440p. On the L440, the SMBus
> companion becomes available shortly after psmouse probes, allowing the
> touchpad to use SMBus/RMI4 normally.
> 
> The T440p's quirk is currently applied to all Synaptics touchpads with
> board id 2722, unnecessarily disabling SMBus InterTouch on the L440,
> as reported by Daniel Salmun.
> 
> Restrict the quirk to PNP ID LEN0036, which identifies the T440p, so
> that other devices sharing board id 2722 retain their normal
> SMBus/RMI4 operation.
> 
> Reported-by: Daniel Salmun <salmundani@gmail.com>
> Link: https://lore.kernel.org/all/20260925230039.236786-1-salmundani@gmail.com/
> Fixes: 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>

Swapped the condition (since integer check is cheaper) and applied,
thank you.

-- 
Dmitry
