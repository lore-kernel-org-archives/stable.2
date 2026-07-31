Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC97370D56
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531033; cv=none; b=Lax7XvYBLG5xDRIjTpfz3ml18ZmvCXpENwXnPeJEs4HLH7QooSJyaRNRkSedgBQkPXFXhbTOLVW9jiawsZEpX/I1M1KuIC4ClR6bJQVwPNg36ZMsGc2uTVXInAfIZk9FpGA4Z3fTiG6bYOKBDj5+HgoZF2gNmNEvsOPu4kpjafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531033; c=relaxed/simple;
	bh=YGtjts5yrFgv89OIosMQ4+/WGxPs6DZ/x1eLh1I6W1M=;
	h=Date:Message-ID:From:To:Cc:Subject; b=eTLUzwUDwh90Vi+OSi1rxHy0yaBG5urbsvKFm084R5C8k9ineRGRhI+Z/TAG/3QyhlmUoTrapQwNwbPWAjm21JIGbPjSljWBIKtcorJqIcr+bePZTAzbvefunW2aIWv6VYd+6tD5YtopO9Vl+QiRhHV26aq1j/DZfSc8PgQqgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=evrOTff+; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="evrOTff+"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 18AE2240028
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 22:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785531029;
	bh=5H4FK0d3NNRSWUW4GHC1PIqT1kYtINtcnEEC7YLJBeE=;
	h=Date:Message-ID:From:To:Cc:Subject:From;
	b=evrOTff+cuL6K09MR+L//eHo8UUm+FyWD6wwc7DkroW22Idcf4d5ff1Q/gOHGUrDh
	 eXPEe6t3CrXCPIAd7nErLdSixCYVoRK+j/POHLdJFhB+olkpN7DtLSQmL04/rBjj47
	 ga/Ryxy/edB86L9FCwdCqc/6Nz04yGBOfyT1eeg+CWD3on/XDlWq9y87o/tAnXRmAK
	 WqGcT8JvGsWVz3VohJq50UKzhIvP2MATr2P1DLSkdoUt5AbEJW9xMbyxz+ZI4Uvbdc
	 v2MGCFEWbAFUGJR/XgOaDV+cAXszEyrJaJ+tZY+93KoufOBa7XBrd5V5DLrKAK+PPM
	 jCoaazvpobjUw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hBdW83V41z9rxD;
	Fri, 31 Jul 2026 22:50:28 +0200 (CEST)
Date: Fri, 31 Jul 2026 20:50:28 +0000
Message-ID: <4391ca99e19df478490aacfcde6e5ca4@posteo.de>
From: Michael Diesen <michael.diesen@posteo.de>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org
Subject: Please apply bed0c8084044 to 7.1.y and 6.18.y
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi,

please consider picking up the following mainline commit for the 7.1.y
and 6.18.y stable trees:

  bed0c8084044 ("ALSA: hda/realtek: Add quirk for HP Dragonfly Folio G3
  2-in-1 (103c:8a05)")

I forgot to add a Cc: stable tag when I submitted it.

It is a single-line quirk table entry adding PCI SSID 103c:8a05. Without
it the four CS35L41 amplifiers on this machine are never registered and
the internal speakers stay completely silent. The affected units are
shipping, and the change cannot affect any other hardware.

The commit applies cleanly to both trees.

Thanks,
Michael
