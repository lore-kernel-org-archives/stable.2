Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2151419A4
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153512; cv=none; b=mkHjUG66rPkKb3G6XchMG8XdXkzeWepfV2c+lUJbzh74sW8tIjkGutyQ2TZwHrYmbNDcENV3qusNG3niyDsbZg9QJiXTY+s6/E2hzKEObFTax532gaCo+giNvNN/T5p9ec59oSG9uiWr4BvgoTcrBSjk9SzWBl8m9hUJAmW68KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153512; c=relaxed/simple;
	bh=gg0ukJS5J8NcQBD0jHL7Al0gfYT5Fl4dmzYH2G9qAK4=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=JOGzobDeu8eA1m36jTuCSX0Pz3KFXdPuAEqcyt8WYowS3ND4Xkok9H6FbM34sIfrk0fFv99UGq/1Afv/civjztHzCvlGQeUAZYoDGwpOGv2l7AV/VwAiMSaXcMR9kP5rzuvZ9qFyYUMYiAlAZZ1xct2NE+8PC8qY3NXJv81m2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5pru+l6U; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5pru+l6U"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5A8AA158E;
	Fri, 16 Oct 2026 14:25:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792153504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gg0ukJS5J8NcQBD0jHL7Al0gfYT5Fl4dmzYH2G9qAK4=;
	b=5pru+l6UV0jF6zlnkPRkhwQ77Szwb9qxkvQJlmVgtLM+gtGG0rVtZECU6c4hgZRGiBYyK9
	BmGps3yScO1PBCKii3g8tpBDGJjlKTUeGt4v+k3S2pY1Cfh0kEPa9Bp4Je1ETh+4/I9XdU
	/uBZ2MN4+oVTI3ZB4bkgL3Xyz/KlXizRy7o94P2+/bPjP9jVzByLbUwYUEvAlaHPxQKllE
	L64QZOKcLOfsTHszKqGVSNwWyh/+W4DOgFr88+3Lbube92EEup00q9oC7foEgBPAv1HQKH
	yFzfhQhDWnhIVJn0t6PvK73cKBHBgTRGE0CCm2sO9nwdCCnm0BuCeLmNRpiAEQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 14:25:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, technoboy85@gmail.com, hirofumi@mail.parknet.co.jp,
 brauner@kernel.org
Subject: Please backport FAT end-of-directory fix to 6.18 and 6.12
Message-ID: <96dbd7d103fa6df33b0bbd492e309bd7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Please consider backporting upstream commit

6a2875517c778ac1111b6920e94cbab91cda8724
fat: stop reading directory entries past the end-of-directory marker

to 6.18.y and 6.12.y, and any other affected supported stable branches.

The fix prevents directory traversal from interpreting residual data
after the FAT end-of-directory marker as real directory entries,
resulting in bogus filenames and I/O errors.

This affects FAT16 CompactFlash media written by devices such as the
Psion Series 7/netBook running EPOC32.

Thanks,
Nicolai
