Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F7136358;
	Thu, 11 Jun 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138740; cv=none; b=cq+0pT19M0r7Fs2wroxzZEC9MI9QKeh8tX/rCCa5pqLTq3KgQRbUw+a4Se9ykUc7gBkQY8fk4+hDYp0nhIRIoHEu3cEifdzjbAsY52PRO906StjtAnsDGaUUbQqGHRTbpt7iPidP67TPo28vRZc4Butp43mHgHnWIOT6Nm2B0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138740; c=relaxed/simple;
	bh=94ZsnpPxwmbWbsDenSNerAD4OGycaXKaD1ytGbBzGBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJl8fIhfaI3bj+WRZeANaVLP2WHNZdvxKJ/OguzOUSTDRQFRp+zI40a+oQKEzp5rmv1eDl3hOH9hNZw0HBnPG6KSL6xU2eZhCaWmijL386/pd7KhjZAwja8ZyJhBef1kZO5tlinx0BZXMQIgITkRIZcwzk+TlwgBVdqENv26dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBVrxxNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBVrxxNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35F1F00893;
	Thu, 11 Jun 2026 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138737;
	bh=94ZsnpPxwmbWbsDenSNerAD4OGycaXKaD1ytGbBzGBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KBVrxxNm+V3hY3x2gZuBQ9CtpzKNti7hXsB757IwRLCDPV9QuQD4lmv87Mva/lyJO
	 e3Du2wNL+W4XVwCegLcGI7+SApuDa7PM7aH1HN904g8RQZJd9FQCrsva0hG5/bJOQP
	 2hhJ32JaXnsxWGVGer/t5/XH53iN+rDualOZ+68Elu7uASOp5/2ipZZKUtPgar4wgR
	 N0rqEjuR5bBkPlBv8zmAODOaa9OMNWvtq5SyP7qQc8oz6U88EMgbjkFgJbMrYiIJmE
	 OKR+rCR+6aVT9RDwVoTE71IXQJiXY/8aGAXkf6oZuPqwiLXX90pHOB214DsUthLCYH
	 V3e7Ujwr9feuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kimball Murray <kmurray@f5.com>,
	Soohoon Lee <Soohoon.Lee@f5.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH 5.10] usbnet: Fix using smp_processor_id() in preemptible code warnings
Date: Wed, 10 Jun 2026 20:45:21 -0400
Message-ID: <20260610-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609164644.31375-1-apanov@astralinux.ru>
References: <20260609164644.31375-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2026 at 07:46:44PM +0300, Alexey Panov wrote:
> [PATCH 5.10] usbnet: Fix using smp_processor_id() in preemptible code warnings

Queued for 5.10, thanks.

--
Thanks,
Sasha
