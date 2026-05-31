Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10C376A08
	for <stable@vger.kernel.org>; Sun, 31 May 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224903; cv=none; b=cMapPI6E9GtDxM/JAu1eIQCcsIYcEmbVXFQRZhb4op/0bTXPMnXPiYtbpqusLmXHua1Gc77YqR2fkMV5gSGbpdP2xxvu+as/EUU3J+pQOP4q3dpdqmFOdP7hYjsjWTg+fMdX9l3OBp08ZAIArLqjeEIhjRoSQiqN6Nf8R9TkGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224903; c=relaxed/simple;
	bh=23Hr6bVV2eGzZD4V9CAprmCqyNkeGDWQ61jdUyLqKXA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKosFPT3f5J1fBxBWk6pX3ahH5sq4GiaytcQoVBPUTe/gm32JzVDjig64mVYbpceN5x+IJwWugifnefNMQE8Lyj/o6vXKfqxoTAlTJGNiNRcaay+XrioWryz2Pa4KUmrDe5/lColvmpYfB9VdBhYh4fQyiCCYMjAGduOkN35smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=yssDv48P; arc=none smtp.client-ip=217.74.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="yssDv48P"
Received: from Stacjonarny (62-133-144-026.dynamicip.ostnet.pl [62.133.144.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun, 31 May 2026 12:52:26 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: <amd-gfx@lists.freedesktop.org>
Cc: <regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: 
In-Reply-To: 
Subject: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 12:52:30 +0200
Message-ID: <002901dcf0eb$9472e210$bd58a630$@poczta.fm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKsb98F3W6w4/I7L4gnl9a4wKSh5rSI9UcA
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1780224748; bh=23Hr6bVV2eGzZD4V9CAprmCqyNkeGDWQ61jdUyLqKXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=yssDv48Pev+PIQ+2CWFB85IQ+Bh6vUyB6EcyUY2JsblfJOKTNoUR7JLfmAhe6gNC4
	 dqvPb+ENrbHGkxt0B+x00HJ4DMy/YsPADm3FfDuKs0HmsHKhSqJllvi8Tlu5OG7HTU
	 s0rGTY07+HRX9nBmszgqidtRxpebVUdIXJG4X9fU=

Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 and
7.0.10 or 7.1rc

Original sparse mail got flagged as spam so let me elaborate:
Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into things
like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems fine nothing
helps.

Regards.

