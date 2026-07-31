Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251D30567D;
	Fri, 31 Jul 2026 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465594; cv=none; b=gdxdUAGIrt6JqHmY+9pFcyegNZ4ZI6zTpx+FRKVNAo2EO9F3DEZkk+d4oGwgUVcb3QGdwX0BQWGlP6JMOJc4hj/hwVxNz+HhQCZqSMDKX0ylV7doF4h247eWEtHKYjdixgB8VakRfwXQzH0rJ6g1+KIoBAWeKtLkt6tznAgFmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465594; c=relaxed/simple;
	bh=Kya/bty4jlSaSL4y9hVKPnS+NhGB6XxZNN0tcenNXOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3kphElWVPej/cpJBqOlIVouJJ3hS22gJehtOgTeyNsoWCF8LFQrjN1tN5/N1sxyVR+P5I8Hvp6k2uNZVwV3N/E+DnaUvDUXq+fyM7lWI2r1Yl3yml58FA5Vd2bXH4/ueLEbmgjqXsi0UIW/cLLDy7HtAxBmfdPQkL/FsJpYzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhcuieoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhcuieoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BD1F00A3A;
	Fri, 31 Jul 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465593;
	bh=d9qrK/f/+MLuISmePFKu73yneVXZg9cnhjUQC4CDVKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZhcuieoZtziFBG/PnK4+5MctAvtwzlDYnO/wLtsfWgxcA2y+zd6vHwtBwSP4vnNhW
	 SMetTTWseWh3EJbYlmxf+mOkQjfTj2/4RWUrUiFm1lokpfdLxk+32RYfGhCJl03j2T
	 roZGUptz/aUUhSxBC+NbWa1L3f6kEdmerAGS1GWxL5WEHZEoAgyvrA1hWLT3Tb/L3B
	 tVBEU5NgbELWYd6BUSRcAL3qL1HxQTHeODoI7lROGpExFAs78T9F4vTdgBpfgDW2YW
	 PmCZg5oR/dRCfUVTgkmQJmg6/970z5rDeR3PXstZSxxJyTARces5mCDK/xJQ8Kv1UX
	 W4OFmMbVZd/tg==
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
Date: Thu, 30 Jul 2026 22:39:45 -0400
Message-ID: <20260730203700.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073005-release-puzzling-8f07@gregkh>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com> <2026073005-release-puzzling-8f07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 02:38:42PM +0200, Greg KH wrote:
>Many of these are not in newer stable kernel versions.  So can you send
>patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
>missing patches for them, and then resend this 6.12.y series and we will
>be glad to queue this up then.

The gap is smaller than it looks: 7.1.y already carries all nine
commits, and 6.18.y was missing only two of them, "kunit: tool: skip
stty when stdin is not a tty" and "kunit: tool: Terminate kernel under
test on SIGINT". Both cherry-pick to 6.18.y with no adaptation, so I
picked them up there first rather than making Florian respin.

With that done, queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
