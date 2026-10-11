Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F4078C9
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707860; cv=none; b=gfOTVIeLy+3A90ZPtM13rUaRgW8jsjVR2JTluh86tNYIabyWiHUFAWj3If4NJxl4R3k0AA8kXHAI+lg+Oo9hdCbY0YWto/lJuQ8hSc3yLsUuvo17m1P4INV6kOa/3uICn1mYrOKICcYL4EL3+DkJ6IVYvrzORD4MTfSAsmdSA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707860; c=relaxed/simple;
	bh=FAOolMCkINrC3lTjV1XO/oOYFDvOm0h61dGOFddLmK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW4WzENC0D6Oe+PCc89smttMr1ENalsT07moFJ3GwIhDzINbVchnVwQomh1uaPHABvu7WYZhI63zjIgBPhDsgzKv92SzuDfZKCZoORmz5jEeP+Rvh6i2X8GKZfSBwskRRs8ZSvDfN6woY5aDWQkLHsAQH83LqP3YG1GvehxOyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPcqT2XE; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPcqT2XE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15168a20b47so627428c88.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791707857; x=1792312657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBHjRRmvdKma54nJSNqg7NX8dKE06rBjHStPBqfNhw8=;
        b=SPcqT2XEljhU7MK0YL/Y8Rba4DQUsjA9ERBEzhESsyVzBkNTnDpy69xRbZkgTfCbo4
         vvFct1Fi94v6apwWwU768XdKrvgWTBOPkgTfTpXv9mJD8laLQEDCepo773gzOspM2eKu
         vnww4m8g5ETALVlLEp/FCVH9Jab1VEKBFPj9NT5fCsUbmeeuko1AK7IbL1q/Hdp0hJOl
         Bf77NRhX08Guj0D1PcGyEtAcERDxgUWakFDLx5jaVHGTW3vpvgh7UlQOTSsuR9Rr9qfj
         /m6j+/eO86M2Bh0VN7HajZMiCM/FMOfvj1J5SSnU9TaW7SmiRXnAkzTe1Y+d1/RXb71U
         FYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791707857; x=1792312657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBHjRRmvdKma54nJSNqg7NX8dKE06rBjHStPBqfNhw8=;
        b=tEWCdKupnSkeFupU0Sx2kmbLkykNFV4Z8/MryAm9ZxWt0Qhl8TVLy2sSoK6fzoPa6p
         107AtSUxRQ1h9dCgF5+Gbgxr/Dk4Ivzy6gOCnxUeEQBC+3KPY1w82sAzwlVDHuL7x+BC
         DTpoEj4wiisiuLHZeV6e8Bli93NPjSf6H5tZX9O+kCShaLqWyUcGZuRSiD72MU8VQ31Y
         qehzY3mWkgPnDwDhBhrHMXYdmNgfR3Cb+AO3kBAfowqnvRkC7yhf1yJc7EHWQOA5qLoo
         OdvzaMmzu9BNApmvydqsnhJMphl0eA3R4JGq3ZY628B7FB7SHDsSxgpdvADyqYUXeuZ9
         XhIw==
X-Forwarded-Encrypted: i=1; AKwUvBw+2ItuJ9RHWzA+uLItRk8yLHbf2Dnu5mTTExAd8sDgNq8XC7Er339PfXu7DqkJdiDHfNkgreA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq4cOEPo+TPBgTL1dtdb/VptEZJYX0eLu2XzINyWiNCMLhaeOd
	8lXls0N+tEjs8eTSYxeOl650zeZeLqtUjUNwy/hiItsppNmSOpfuQSWL
X-Gm-Gg: AYBFou1kfFj1N48CiuGk87ErBK57l0xVpemjiMDJ/1C/X0A1gJu4PogjSBlBJ/0Ly5R
	HGzcn91LbFRFEyf5fkY/ogWYuDnS1pMf95LVlhzTDCDfLnPF91IiIE9tatHK6e8KMKIuxyTZ5Gc
	l4N31OBFQX/fflaQGnXAC5uS/x3gQ93qi+tbBhAvAG0+dHgBTolx61QG8dg77e/uc9BRWhZMOkO
	9n1DDTwsVNz/aUtqvWPMGoaO7mZH/J4sV0IwI999/3hyW7P2b8XSS3nW3zQfO7PnEc7rroEQaiF
	znrTZdtitNe9ZG5P9M2oUXNaKMcCCTk8TSf3zww1960S1QbK81Uzip8uceklE/7kMWKkxHA8s6I
	iFILSjLaRDuZY0+AB2DfeGymgYXQbkCbetcvD4eabmODzR2WiScI/aPM9qAkbOmhRR0RfgVvFeW
	fSwESP6HSq/L0mgc73LtyiouzG627FWldvIjUUq+wBhPnRRhUfNbsV58EUs+OHi3mr4xwkFzaM8
	FkSTun56haeEIQYdrN49UrWkwO9D1MRwR+DRKM4dE8fuvKaZ42cVg9CNL2g9nXcm9/s0hHDpEtM
	LvkU8w==
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id a92af1059eb24-16a5ef28a5bmr8084789c88.22.1791707857215;
        Sun, 11 Oct 2026 01:37:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a42407e7sm20186473c88.15.2026.10.11.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:37:36 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Sun, 11 Oct 2026 16:37:26 +0800
Message-ID: <20261011083730.223083-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for out-of-bounds writes in the RMI4 core that a device can
trigger through its Page Description Table.

1/2 rejects functions declaring 7 interrupt sources, a value the RMI4
specification reserves; the driver otherwise writes past fn->irq[].

2/2 rejects a PDT whose interrupt counts grow between the counting scan
and the function-creating scan; the driver otherwise sets bits past the
end of fn->irq_mask[].

Changes in v5:
 - 1/2: keep RMI_FN_MAX_IRQS at 6 and reject a count of 7 in
   rmi_scan_pdt_page(), after the RMI4_END_OF_PDT() check, instead of
   growing irq[] (Dmitry).  New subject.
 - 2/2: unchanged.

v4: https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - reject functions with more than 6 interrupt
    sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_driver.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.43.0

