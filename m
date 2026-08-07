Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E251385D98
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118909; cv=none; b=s5FQ2FYo5wpR2Zu5mx2wlveCtACaLXruleoF6hNVnGSC3EZnkM98B1Bj01KzCpPe2MkdoOLz4kBqkBJGDKwWDM7wfdjiTkWA74BcpHURlb/lma9tDBhPJVMYHshM8pl/osM5VRWHqvjLXNGVcMAhkv6LhA7OmaYtOuE/KBD3JDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118909; c=relaxed/simple;
	bh=3i9Yg7zGiG7NLreB+R/L9yBxDBd3PbX+sHtmLQel8kI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I2rKIohVO9ZyoO70C4WLON4eT3vK0J4jhfZv/pSnuZzFv70mwR+JUPY68DrFv1mBYa5/7Rz8sUGQBSdp8/NhplF2pvpg7Nhb3qlUuhMerAD/GRDceEKv6GJPVulnfrT17pTbm76Y2syumEus4qAwTtMD5mP2CHT/ijz0W2tjYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=jGyGMxT2; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="jGyGMxT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1786118905;
 bh=gjOCGq/lgPEAyIC03TEeRPE1lC1Ra5aHVVKGkvFTmzs=;
 b=jGyGMxT2GQYBWIBOx4C1909p+dbFkaEZmjmykKxaaaMu4VfVpCVrcnWdS8IgdlNwlliuWh9oF
 xSSSMNSUO2mvoWTlHQAds3fX5zPcE8Vq6nZz3lTXUoYMKy0j4l2Uj2KTdPfQuBIirs7uh7JRA05
 Qyj2BSHFZR/ayq8QejdXTAo6MjKhg5tge7HVPxWBNq40vAzTScIo+r4eMErArFdwtw4yoq8wRF+
 4dPkYx6+UDGJOJTgfYtPbfxDM8dAZAxu16k+lVARKHWhYvgoMts5iJlz1cDUlQWHzX6PEdw7x1m
 TcrwohCxIWxcbTXHPIgsuJNGDCvklF5QGjP3UqhGuUTA==
X-Forward-Email-ID: 6a760270c2d7d501b99555b0
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 07 Aug 2026 12:06:07 -0400
Message-Id: <DKIU9E13QG3Z.2V2PD3QB9BXR7@ubuntu.com>
Cc: <patches@lists.linux.dev>, "Sven Peter" <sven@kernel.org>, "Joshua
 Peisach" <jpeisach@ubuntu.com>, "Janne Grunau" <j@jannau.net>, "Sasha
 Finkelstein" <k@chaosmail.tech>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 7.1 335/438] power: supply: macsmc: Support macOS 27 SMC
 firmware
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260807143428.008222056@linuxfoundation.org>
 <20260807143435.115379040@linuxfoundation.org>
In-Reply-To: <20260807143435.115379040@linuxfoundation.org>

On Fri Aug 7, 2026 at 10:38 AM EDT, Greg Kroah-Hartman wrote:
> 7.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>

Not an objection, but this did fix my problems with emergency
shutdowns. I'm not sure if you can promote from Reviewed -> Tested by
but if you would like so for the record:

on a M1 MBP, after applying patch following macOS 27 update:

Tested-by: Joshua Peisach <jpeisach@ubuntu.com>
