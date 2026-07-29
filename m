Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8E3DD520
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358220; cv=none; b=kRYRzlJbhne7YRrqcEi6BMGRXXCJ0crqfBiq9awnFVil8rLv0KNHM936RbqwqitR1QxheGIE8xyn4lhLnztYd7dR18fbk3J1HhF255MNofwu/qsKwRTFWD+9zEShUKf+PA2VleBN21ViRoxfgciy4sAL53KaRUDwR/PluepcQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358220; c=relaxed/simple;
	bh=BdBv80uVeLso6mBU/qxFiIqHqglqtLJWFAd7JVhev0g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=YqXKU9L+pHltANJO4AxM+iIumYtFMXngpdChyQIOKAvuMXrCQTTiByazQn3Irk/ErxwgamOesjUvS8zDDqlb52MF7dayR0HvHkjjpSghDVNk0mAZGCHgDlerdHrXR4S0MrwotgfQSbUSNHdK0uP5MoBJX1K/quz0KmYtBTuuKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rd61MvJw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rd61MvJw"
Message-ID: <cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785358202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4V0uYILLLmWi1zXVtRK79wMEUQGUJRSRL1I6YGyESFg=;
	b=rd61MvJwaO9p5jXN5o6yKxMvQr6C0Bj6zWzoHuIfOiTFuB0diMEobDZmMFaUlEV3eB4FWa
	l+lUVw/XvpS4Y97xWZAQF5qMEdUaC6RGuWDsRgF2+PaaqK+Clr0YDCpHzLQEfgwXmSDVYf
	n/bXPmSWQ2LOVPeEsf9iJFNhW012pFs=
Date: Wed, 29 Jul 2026 13:49:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: regressions@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [REGRESSION] thermal: per-zone hwmon names break Steam Deck fan
 control
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello,

After upgrading my Steam Deck OLED to a 7.2-rc kernel, the userspace fan control daemon that I use stopped working. I bisected the regression to d6323469bcfb ("thermal: hwmon: Register a hwmon device for each thermal zone").

Before this commit, the ACPI thermal-zone hwmon name was acpitz, while after the change it is now acpitz_0.

The device profiles for fan control rely on the exact `acpitz` hwmon naming like the below code snippet:

devices:
  - hwmon_name: acpitz
    nice_name: CPU
    max_temp: 90
    temp_hysteresis: 0
    sensor_name: temp1

So now, the profile fails to load with:

fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
fancontrol.py[40528]: Traceback (most recent call last):
fancontrol.py[40528]:   File "/usr/share/jupiter-fan-control/fancontrol.py", line 606, in <module>
fancontrol.py[40528]:     raise FileNotFoundError("Failed to load hwmons after 10 attempts.")
fancontrol.py[40528]: FileNotFoundError: Failed to load hwmons after 10 attempts.

Because initialization fails, the daemon never enters its fan-control loop or writes the requested fan target.

This change was also backported to Linux 7.1.5 as commit 996957016bc1, so the regression is present there as well and has led to a userspace ABI regression. I can look at accommodating the change on the userspace side, but it still seemed worth reporting as a kernel regression.

Thanks,
Matt

#regzbot introduced: d6323469bcfbda91f0aa89b7b39ad45fe822ca5d 
