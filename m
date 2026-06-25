Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880526ED25;
	Thu, 25 Jun 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398856; cv=none; b=ooHaTFzujJLgfEjaA3QGE/Ytn16iyklB6hLQEkZ37j+UfKFIWlqE9yjutmELHIR1fbsRkmwIrbsrH+QGIiVG1Qkis/Us11fX7dFflNYGku/NgFxiZDHCX4xZT2gIg6lzZOaurHOtKfPz2+6II17LJJ5uW9oMxgecR7z+cw3WoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398856; c=relaxed/simple;
	bh=1PO3YHl+btPykbwTM16jfcwADiOLFguz3RVcskKvjrA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=S2sLVnSuQxXhlqC59m0sIM0eZNqMOWe8uADKwHC8wvksKIoqcaLuc3OULMNr+HXQjCAb0ZGQhprBj4ej5OIyawwZxgYleXOGycEYOorHm+wMxrBrV40Rl7CQvgvGOJvi66UOM9F1J1fINdVzj2MZWRepJS/y5ckK+L1+QIvsoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=clDBfDsf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="clDBfDsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782398852; x=1783003652; i=rwarsow@gmx.de;
	bh=1PO3YHl+btPykbwTM16jfcwADiOLFguz3RVcskKvjrA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=clDBfDsfAaPf/GGE1AgknuWnmYdIEyct1AS8w4W9Io13BTyjt5+YzvOTfZj8nHJZ
	 rVSWhzZiSp/U+VDUUNgpGWdRRIxzBlL6Kp16ZujnQ/Nnf5vBDq38caX02wi5gesJr
	 JJSHAAfnqjEAuG8U0DgY04zzVTGCD1foKYlXZyQTe1/htlKGh2EsQsGpOEOe2AKPr
	 OjErWPuHmh1o+NucI4dMAvFJcaY6U5gGKG2FWntkfgXYuSi4Are1wFeLjiMUXc44y
	 YbNdaWiiy9ZIKdayZanXn69smoACengoRQN0RZ5unTj/HiWMpcZ16OT2Bs0MMfmeH
	 Dkl02chM/95J7Ly5UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1xUJUM1Ux8-00t0fN; Thu, 25
 Jun 2026 16:47:32 +0200
Message-ID: <958783c6-826d-4e81-a840-70d6d6f1757b@gmx.de>
Date: Thu, 25 Jun 2026 16:47:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:251JYwyItmu7JD75xF8sdK6PH2cEir/C/fX8IM0G7EgblLTiq1F
 gf2BxUdJQEPp3bMyHEs9PmrDTvQBy0/Cay3QXl9pytlcxFXrTJTQovvAmytm5DPMJVamWqo
 2+Fk88er4ytRjdkcR/VVa5oIR9pRKZioIidhwlPPWQsyUXHhu543pvVc1RnlXusKGQ9D2lY
 MGJ3aEpudm13lJS6q5LeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y7Hu/XH4Tww=;18chbAtFrTojOrcMKrrEY0EpWsg
 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

Hi

kernel build / boot test on x86_64.

No regressions here.

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
