Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB33385B6
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231343; cv=none; b=mz/djubqQCATkXB2VC2NyzHktciRlZGgSy/vCgMg4uYXEgzL7j7Cm5J8voEBUjKnzEefG8wl2zPB5QdSJGSeWiIDTjJw8wEuA+fOi78gbb5wyL+t0LXOhgN8XOLrAJHrrZALqsSzvn9YX6hyuZXz+DmwjwdyiAtRjcIEJluz6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231343; c=relaxed/simple;
	bh=7Iqd72ncQvRQKUtOsv57UJkiBgYzW1kb6U9Ky0hglWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPqGQIonFlM5U/HwM2VTgLcbGKUDxJD9L/DojmpP0a6NJaMkWKshHwcCQPNbiss4jDH0qiGmddrT6/TmgCSlSPdFFdLG13YM/ZCfsF4JIJQZ00KtO7b9G4voKTX/0dXp960j+R+fkPsC4Y0Z9+ritzfAR3PrxsL2KsIZ0I9I91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=twaQxo7Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="twaQxo7Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf237e1433so5271325ad.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1781231342; x=1781836142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgU70E34PD3X1yhIwgVvpjjd0mgVE/TPAEH2m3iVtzI=;
        b=twaQxo7Qa4Wxhdxe128gyoII3L8LIsd9YsFSrCZdlsUV/slimGEZTUAXYV0sDGxm+K
         t2c5UvaGNVga3geif7U6zX31VeDGsbTsCvf7JLyEO/FfH5fO5ONSOEyxIJTlyQv2dnwO
         SOxxYziWIs+Qrh24K/ow3/10+BmseOysapNsO+UIVTbTC2QmKeug7vcuZmqPKmNanGf4
         AGdloaKnJD78cu8lHuU5TwgymuT0YZMqS2ft7CqlEAOY1joe3Ft6YuBjY1jI1+LRyVle
         KSFi4tAcEd2I4uMuYKZqLHDD0Q8XtTJdwiZXhtXIw5HIbuvNFOT1Zurggae5fROKKanU
         HGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781231342; x=1781836142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgU70E34PD3X1yhIwgVvpjjd0mgVE/TPAEH2m3iVtzI=;
        b=tRIauzPUupXjQzhh8QipOSMnCOGzHbwJ/lb1ZjfDJDvvftxpai/AnObaNErkNaLzou
         uOmiAZXZRjNj43DJIW6/ZIdZop9HZIyuWUJaXfaTbowsxYEMasOa+P+SZtw9hM69NA+3
         cHOIZxb62WfFlXR1tdaAw6YRgdk3pYTYh12zejFkFEwc5njB0GeUuxSI742B5vguqKo0
         zJI1tftm5xBUG6jD1GXvItEBXZBU0Sir7qGgSYW7v6kznitQbqs8K8zh1sMO0ZtYIxX0
         /WHhcY2v1r0Ggy5K3/mJJZRCI9VmMBq6LEHP565vBLuqcQb/9XWMLv+u+aHYEfOcIZrL
         LMcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8arK1NbOUtXIns4rOSDTNJiZDCaDaCjF7+4k9W7F7bGVMQQafzWOBdk4PE3i2xphQ6ofsBJtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdQATG+pWq2KT0Zr35zjGlr3wXlKatAoP7YXh7N2rnlTWR5zY
	YVY1mYl8w/we0l8e7a9rOH3M0hRVb64bWglO+lkTDmwCyT8DQfbqONKNnFcO6gGfnDY=
X-Gm-Gg: Acq92OG9oTarECn3OTr8FGCUnRFtAcUbgy/6n+nJD/JnZq7TfHRdU/HqRKNqUHAGFuc
	PwHHhoQV6gYDiO4P/aPgaQ7jLeQ1gMDuW6qJ0m6sYNkJF23lUQfnWDUpMi2TbgOKqOgzzyomEtE
	o0d/Pd83/KWdF5CsomLG0GyOtLRO/yUCSw7yCx/SAtSGw9Ai1rJ5pEUl4eQy+hLRJ2olY7HQdtu
	VbxdngOG43cWi+0KrCPkvgTfQCrLlS4aDlJQsdtN88tkZsf/Weq6rthvLKu/dWJmrQJpmBVEJbi
	65Hl3izyO+LV+xbt3LjcNpstjSIZNBwjCTEIGaS8kM3f2Z4SIwHm2HAvXnQSX6rj1Bo/3wV0MDS
	Za4IabW/E8d0zhERbSrI8MzvfwfNmREuS2iySehn44o8Amj87qgVoPs5znDD7M03dA/LlY3im1n
	Uku49ugxM8ObRdIWa84b6SrmbuzZ4SAFEOhgQliZzlotPuaP9+mr0v3ZMz61ExaWsK
X-Received: by 2002:a17:902:e750:b0:2c1:e04d:7cb5 with SMTP id d9443c01a7336-2c412841372mr11649715ad.34.1781231341705;
        Thu, 11 Jun 2026 19:29:01 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm2952795ad.26.2026.06.11.19.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 19:29:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:28:58 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Pedersen <thomas@adapt-ip.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: cfg80211: derive S1G beacon TSF from S1G
 fields
Message-ID: <d65nudgv7m4s4ymi6vplknhibbqo44vetpt6fjdig65tahz5dh@7p4wzkmpjbm2>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
 <20260611161943.91069-6-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611161943.91069-6-enderaoelyther@gmail.com>

On Fri, Jun 12, 2026 at 12:19:46AM +0800, Zhao Li wrote:
> cfg80211_inform_bss_frame_data() parses S1G beacons with the extension
> frame layout, but still reads the TSF from the regular probe response
> layout after the S1G branch. For S1G beacons that reads bytes at the
> regular management-frame timestamp offset instead of the S1G timestamp.
> 
> Use the 32-bit S1G beacon timestamp and the S1G Beacon Compatibility
> element's TSF completion field when informing an S1G BSS. Keep the
> regular management-frame timestamp read in the non-S1G branch.
> 
> Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

Looks much better now when passive scanning, thanks :)

Tested-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Reviewed-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
