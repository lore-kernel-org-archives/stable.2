Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAC3CD8BB;
	Wed,  3 Jun 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499688; cv=none; b=Mf/+QMcuHcb1MPGyg/vt8/2F+ni0Ixx9eOEbF6Hhf9+dIhAvlJSpd5y7INj7hh+mwb3437oeAjWeBy4WibrloFuUsIDOAtKmJU073CFzdIFP6/VXnIlZHjdELVtfNmd/1EzWyM//O7K1kiOuw6AcNZaSCLjd6IdkGcB8icPgCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499688; c=relaxed/simple;
	bh=LxgTUKbn8KNhLGRhBso8SsMhr0Dzs7JAPcOk+R2tsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe/FBiWHiSWG70e4IQkSVMtW5yxqd+qHEfLLIhPxAw0fdR3IKECCFWraN+JXIgoFcTNic3m+2L1RZ+eJ3XlyViqS5VIpmqKZpF0woFtsfk8QGp4i9ZUByjwt26lcwp0m/IVolNc9GQhYq9gk2oB3H0PykyEE32l1kx6XyT8gIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSdMqSPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSdMqSPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B71F00893;
	Wed,  3 Jun 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499687;
	bh=6ujqYMqXB0/i41pw2tThC/BzMjS9s70+BOjvuc2SkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSdMqSPl2HS0O3gNNG0z8SDxubJ5Tg2tHpX/XfFz91ONcRw/Hi2k9QmlEDETFKLn6
	 7P/AW43vSdyWfm3gzjvaHuS+PNty6Fd/AMLkVpQsql6FV3JtUfprsubcQndPnS4XUB
	 jhXu2x5LqcBFgcDNlF1Ql5lXrfPpG+l/DWSL5Wlm3+iDU5CKNlrwj1iCgRzGiwGI6Q
	 LtAn5JCi40DF6AD9olXSN051tl2xQ/xwqxNI5QZpx9W/intmYjZaWHHAUWPn/FrKfs
	 /XDAK4js0bTz2NXehDxp/sB3oVpftJ1sV8HhtV2yRkAsxSx22aCMQHOYy8ni88cxTP
	 CLfzdvTmBgWAg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y 1/2] drm/fbdev-helper: Set and clear VGA switcheroo client from fb_info
Date: Wed,  3 Jun 2026 11:14:11 -0400
Message-ID: <20260603111500.item036@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528131817.59900-1-jetlan9@163.com>
References: <20260528131817.59900-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
