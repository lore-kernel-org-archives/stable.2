Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379D3E1CE5;
	Tue,  6 Oct 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282495; cv=none; b=EpZhWo7n4CZDv4EhNDm6JMZPPayBiYailp4OdwEvyge1atB3PRJJ+6jZ7bBgbqnfDEg0pwRFEv8k27F5EPVVkJ+696pSYJsz/+uHjvEUOe51u2I8ifQ64xsLfsETzfTD11nF/b+5gYqDeF0zOeIkAIQ9QzZZwSoLdv4YjLpeGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282495; c=relaxed/simple;
	bh=KvpUgO4CgeM1LxzsybrYaeIDHm7F18kJgkihCFrt5GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPoNx6zxze6PhiIlCLUYra0vVrZuUUdwOzHoXB/sxgi/3IzFOI77oLHAqTb0NAIcKeYqOCmjESEqeiiY1hziTec7z7FAe7qF12gc3zMJvAxYkgOi9Mr20aFgAKTvDmB5pmGGBozpQMtyXAaEFpmkVk/7OJlEFaKcN3nRGQ99K0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmqQzSdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmqQzSdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC11F000FF;
	Tue,  6 Oct 2026 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791282494;
	bh=2VKeccy7Y9xSH924RYBehid8QY5Hd3vjaKP5BDtP67Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jmqQzSdIPW98aNTxfz2htTGb0Rv/ruboCNOSP/lDkG3cSJdXuuGVLFnlFh78Y576g
	 Px78bpg/CoQjVDc/LiMsFJv4euPUicb3/D0cv8xhaXK1+l3U70/fRlSV99Hdv62YqH
	 wICVD8rdDsGSPP7uJrXaSpZGvoiJUpXO0a4CsnFOoy7B4ByNKvwpFTuLIcwdg7tuWA
	 etn0lIavufOFJgX1cG1+Pvqxb0qpVZIv2dwYvJ196GnoRtW0PCkm0c6LKyAi2R6Ll6
	 7d+yQxxh64cM/TPzCCDbQ8zhURiDTjcfqWlamyTd1vpZ1CHlelqlNZmU0cUecb1TqG
	 6Mo+tshn92iXA==
Date: Tue, 6 Oct 2026 10:28:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: James Fairweather <james.a.fairweather@gmail.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_usbpd_notify: Only use parent
 drvdata when parent is GOOG0004
Message-ID: <asTNOr4A_dD5Kiq9@google.com>
References: <20261003222855.23707-1-james.a.fairweather@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003222855.23707-1-james.a.fairweather@gmail.com>

On Sat, Oct 03, 2026 at 06:28:53PM -0400, James Fairweather wrote:
> cros_usbpd_notify_probe_acpi() takes the EC device pointer from
> dev_get_drvdata(dev->parent) and assumes it is a struct cros_ec_device.
> That only holds when GOOG0003 is a child of GOOG0004. On older devices
> without that hierarchy, such as Google Nami, GOOG0003 and GOOG0004 are
> siblings under the ACPI EC (PNP0C09):
> 
>   PNP0C09:00 (acpi-ec)
>   |-- GOOG0003:00 (cros-usbpd-notify-acpi)
>   `-- GOOG0004:00 (cros_ec_lpcs)
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_usbpd_notify: Only use parent drvdata when parent is GOOG0004
      commit: ca75b38b1a3c2eabe81d231dae4ea180cf6287cd

Thanks!
