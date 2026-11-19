Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099686;
	b=dkOkVoRAzfaxV7r8FmIVUMgSmrmmfpn29OgWwEo3hXCiiSUFQTmvT+FxS55lyW+QpN4t
	 9wNo0254VVod6AsW0iZeIQj2L51bEjqKs5KXgrOcHl1y3BiYgFnYduwNHiYFcG8MQSCqe
	 +goLYuQXCoD2u/SE3+xniQXJyWCkCI5DiFsqn6n9ZWUH1uL9LJ5Sdxpa3yIXv/5Mo0I8R
	 gvy4OuapSYK9hDTp0xf6Y8GdkBX8KWQOmBHBY+6APy40u9nfjuZibtUXVfsDVLUnW6vYJ
	 FYUSqtQlOJ/HBrv06y9U35zZVyC70WGE2pPIqHV2ScKIH+5k11YqtMv/mTwViVVLYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ILpmCzdrOhZhus3RgSR2/cL8gaOaX2QhVSOKx5A4FFk=;
	b=tu8x68Qd/633dsMnaMTbu+tIHgEiEK2MxTsg+90WDIbYUeCElAisqoO908dnco+3J560
	 uslLI5HVJyBuxioAe94sJQqA6qI5YrbQ5zcQ2gAyal8jTLkw5sDMOM40VlGfzM+MoPFPk
	 PjNxputexwRG0T0tjF+WVfGsCtTw0OCK9Sj9VmdaEO0cRqErPG/DD+YnaHgs4xRm/CxWJ
	 TPXex65S0vM9SY6Rb/0ovW8Ns5mJdnz5nOxbE/ZVND9Fs3o7ANVgqPZcQj0XL9FCKOUMa
	 wlys4yj0SswjGD5Y/0sFJ+nW5ctFmcATwdm9qWZWQ5uZ321rmIkfxkJZfMq3F204Hfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b="UU/ZTdla";
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1D60A2625
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D1D60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=UU/ZTdla
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElcPT017978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099662; bh=ILpmCzdrOhZhus3RgSR2/cL8gaOaX2QhVSOKx5A4FFk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UU/ZTdlamL1B1juqeNL4Sps0PXWzyjyuKzTA0ytsaE0DM3fKhe4iyIzP0ujZkVSuE
	 fcqUKxSiXDh9BdYtDBpfD+e+yerdRqu+YIAiYAAdb3hoDZzfSxsYU1owZgYagnu+sv
	 oFlZXLosjTKbGI7ZnJWxdGxTbIKx2GDgC45iXX4rp1CDLWSqmjtLT7k5fCnFppHg8o
	 7PHYa68oEljbhlkxdPYdPNskB7PlYiExPjQJb9POX/K73egxz+UXbFeivXrF8clGR6
	 oS7b07n+78F2OJV3BsPa5ze5zDykZ072EA1FgMlHxmBsOr/KXsgFhne0fhZ3bbH4xF
	 AZj8tAPx95oyw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F24182E0159; Thu, 19 Nov 2026 09:47:32 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Fan Wu <fanwu01@zju.edu.cn>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH v3] ext4: fix discard work use-after-free on failed mount
Date: Thu, 19 Nov 2026 09:46:50 -0500
Message-ID: <179509948665.1938961.14789019043094337911.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909113703.698544-1-fanwu01@zju.edu.cn>
References: <20260909113703.698544-1-fanwu01@zju.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Sep 2026 11:37:03 +0000, Fan Wu wrote:
> ext4_put_super() shuts the journal down before it releases the mballoc
> structures, but the failure unwind of __ext4_fill_super() runs the two
> steps in the opposite order: failed_mount6 calls ext4_mb_release(),
> which flushes sbi->s_discard_work, and the journal is destroyed only
> later, just above failed_mount3a.
> 
> With -o discard, that journal destroy re-arms the work after the flush:
> ext4_journal_destroy() calls ext4_force_commit(), and the commit
> callback, registered once mballoc is initialized, queues s_discard_work
> whenever the discard option is set, even with an empty freed-data list.
> A running transaction can be live at that point: replaying the orphan
> list is the easiest way to get one, and the quota paths on
> failed_mount8/failed_mount9 can leave one too. The final force commit
> is not necessarily a no-op.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix discard work use-after-free on failed mount
      commit: 7d7c94601664d19cea230601f377e5fb8a2ec4fe

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
