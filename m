Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA51199EAD
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367868; cv=none; b=fkUVu5dZzPdjk/v08gVVqA+uYtGyKyrHbUJVCM/nukTy8ncreJV3/wvV2+O3X1jhp1kvDaqULGS1sZbRmswN42rpZt1K2omJmXkdh7j8zn3PfEutBJt1glk57Nm9/KXKIf3eNm4+JMqf1PKHGqSim227eOiBnsB3s5Gok5ezink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367868; c=relaxed/simple;
	bh=P67XwcZ1DX4R7Cg1fbHNEC4NaOF6Qa6QybDZoclNTbU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dBFy/2+P9OXC9zCCxH3x8heWFJbicxmizmKNsxytDZKMtbFGvFtxE6ZItReMfgqmtc3/RCqUibbkoBchUR2tjrwmQOYc2tw6PbuycW0zt598s2FgTDK13Jbwm6fgGsZfgt0NIB7mw1NsI4o5DY4XRHtWS9ZFr/l/YcczTRN4LFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWuS8lj3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWuS8lj3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49553515a8bso29286985e9.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367865; x=1786972665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l1CMVipmbLqPHH1Z87jBKERuOVWvMOMVff6WFqRXZX0=;
        b=FWuS8lj31cU2aNHXAMxoEgeUS8/YSVc9eTCXDvDc8A05bXtQZVfGrzSECPXNJ9X065
         PhjbZ/bE+uNpaSHGE/t0JX/LqpMp49IL44AaEHf0LCkQn8BW4w8+J9apn6sI8dpppqlI
         Fz6ijIOtjcoei2/S+5oc6syx70+PTQ6FBBXazlEJr46yGfXMwsiCmsQqDkDVGRA1XN40
         hY+Osvbo0EukeTgK2cGuMQP4At/ZGHo9Tlww4BJH1KvfpHUSgJvlWxegefF2X2G3Kl8P
         wCeiqLL/BUIzg4IS3Uzi4y2C9a6ORiY3sBx93daQXZLzEHRBgnZ+9Dfn+HTe40o6A3Ic
         YOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367865; x=1786972665;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1CMVipmbLqPHH1Z87jBKERuOVWvMOMVff6WFqRXZX0=;
        b=XW+p4P0j52SydLJNNQqPLiwXUTx4m7xleGgUcV+NYAP1oEXVSG33ii1xkZXDJGHSs+
         Luk4cYyKFKZ7PwBm/tdbAJi+DMlDoRBhlxmJ8JZcGHIG71anxRI0OcBC3qevCBHa2muk
         zY4NDOXEz/dFTAqo9lbcokx9OZje7iYht3nKCCu8tGKMhNCa3VZvkFisj4u9FGFWqEZk
         LpGV6mJLx8C8W1HNP9BD+Krc8qkGcx3fa0hCQLJ7HUE4zTdFT3Zd1iwj0bcElNNo0fxA
         ZfcvVx+O5pBEo6zq4n4ax4Q3FpEeGexzYysoKQoDbYoJnPynzABlu/eGKBVVFVSXNHcS
         wmcg==
X-Gm-Message-State: AOJu0YxU4P8MKkpTvxKbirKL4tO8nzpjaeDEeNN60LcEmNrQQTbZcTGk
	q0h5YC43v50cfD49xNau0i9nY4xEYdRiotQfxJ06m/ZnOVuKeRk7nCPD
X-Gm-Gg: AR+sD11TvCKdkLyq8zibkG8MC2KbhrcvEJ2pXwmc8+Iaa0aUDiSAmjySq4Dzqa4s8Xg
	7rSSpebsvYgLkDSY00IAKhpZiPX2EKb8YpD4Xq/0DmlAb3iAtjCXyVbx2l47hS4n+cPAVxQIfxz
	nWDJzmeJ1pMqIGL1E3M3wxlpkft7cbqtNrA+e/5MEP/qzkqS5+H0wfFG4g0P6Y18J1FOIJwotW7
	TlgIpczirGcUJz1aeg75VRv/o8JO/ah2NE3Dh5+AlS4dlHX6Dk0aHDbZtd8jNT/C0B+NsUYKwnl
	YQgglEAuEtwyxg/nOkLhKahq0BrPNqOcn8VQpsqN0UCDnJCl/UtE0LhdMK+C/gxuRr12Li81dP0
	sUNwIL6cgyD5xcmYdN5/SlzriVLfzHivlCKXKk79OOQlRVFwhOXRU+xhSUf5sUHB14SwL0cxgnC
	+arX4XQsIdDf9RPaMvZy5OJhqmW/9UqWwD/t7AZHw4XBdYz8hOP4OsMztJKrfsMQG2egVlbLkMj
	tIa
X-Received: by 2002:a05:600c:3b04:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49959e016f2mr394539345e9.3.1786367865103;
        Mon, 10 Aug 2026 06:17:45 -0700 (PDT)
Received: from [192.168.10.195] ([188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7a56c5sm308864975e9.3.2026.08.10.06.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 06:17:44 -0700 (PDT)
Message-ID: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
Date: Mon, 10 Aug 2026 15:17:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, it-IT
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: stable@vger.kernel.org
From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

after having looked a bit more thoroughly into the matter, and having 
gone through the relevant commits that introduced and subsequently 
modified the AMD backlight brightness code paths, I would like to 
suggest reverting commit

1191285ecb4233e5bf907da7e9394d7999055566

from the 7.1 stable series.

On affected AMD systems this change introduces a user-visible brightness 
regression: values near the newly advertised maximum can wrap around to 
the minimum brightness. On an ASUS G14, for example, brightness 64532 
gives the expected maximum level, while 64533 immediately drops 
actual_brightness to 0; max_brightness is advertised as 65535.

The previous max - min limit therefore appears to have been significant 
to the existing conversion path. While commit 1191285 fixes an 
inconsistency between actual_brightness and max_brightness, it exposes a 
range that the current implementation does not handle correctly.

For stable kernels, reverting the commit seems to me the safest option: 
it restores the previous behaviour and avoids introducing a broader 
redesign into stable.

Longer term, I think the AMD backlight code would benefit from a proper 
rework of the brightness coordinate systems. In particular, it seems 
cleaner to expose a fixed logical DC range (e.g. 0..65535), map that 
symmetrically onto the firmware/hardware [min, max] range, and keep the 
firmware custom-curve 0..255 scale as a separate conversion where required.

That larger change could then be reviewed and tested upstream 
independently of the stable regression fix.

Thanks,
Sergio


