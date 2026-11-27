Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798903;
	b=D0KE3iLdlNxZRHSmAANE7aZzzTZs/eRixhPqI/6k4bGxsnN7g4FF0ozSpXtN3jQqdAJ+
	 w5hyVHUeLVOhZAg4NhUNPVUGE09VrFh1D2+pclkN5f+Ui6aXeKv2lx/JITYbqsv7lRyXR
	 ORZRvBqJPn4lf2TIf9Jkk7a/GJK36uVq2dgtFFwUuIjIXpFRutuazhZDO3ViPyENIOEEt
	 47jyXByzOhNxiwIcW2auYuJZJg300DFlk84pkuV61cRTMi2VAB8DiC1cF0wXnZXi05rR6
	 joLNWg+fHwWQxhKHGe8wvFYJgVE+q4S2lXMlTrDW9EC5YPmjZ4g7U8Z9pJ/yS24e8jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798903;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MbHC91Wbq0zoJWklRyEojsCwKz1zKSMvghJRRGR/13I=;
	b=OaLpK863ZU7Ct4JF4wQ7gfVZ8nhDEV31sJxrnWO1o1P9iE7ZWFSpAAuoZyj9U3C1s2WO
	 HzNjYO7q6r1+BHWXqTzsK12FoeR1cNakjimBHn/BHILAA7z/YF2M5RBNgN6oWWskT4Sqz
	 Y7DDPaRdpwmmOpdw0RqEHhTA0KidCQjXN9BxKpfwWDsjqlYVHFuVQ0ZCKQgTA3y8PV6uK
	 rS0WQjoswVS+09oEkha6AEwJr+auWbWk7C8kQgvbySKeLmvCe6qNTXeb3BFPAsO2PVvpf
	 OLRukkMagXLAUKIm/k7kj0XStjNb31jap7ihVCoCxA/9ydmWMspZUr5htp0ILdDlB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvQ0KP4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E57606A31C;
	Fri, 27 Nov 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvQ0KP4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D472B1F000C1;
	Fri, 27 Nov 2026 17:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798903;
	bh=MbHC91Wbq0zoJWklRyEojsCwKz1zKSMvghJRRGR/13I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvQ0KP4GvxEON6+fuamoYvvOk8OVjSU+fxwhF11lxhOsy7lB4LPBoyyOtGrwwcous
	 Fr8XjVNPGQ4IUaIFCtwVxbA6Lax+gMMkheRrIuJsIfqAxZ4M9ha3elEtpnD1lOeElW
	 TdkOGjgcBmu9AJP2vNgZnaJwtmR0/ihndZU3Jizh21V4xJFLeHBapMDGmw9VsYRbDQ
	 9H/tIWZG2WuMAOU+ujOO8NWgnDWdEIKJpJF/Eza/MW+vDfehgocWpbMKNyszwtZhI6
	 OOgtRZR8SMB83++BmCcYsTq62u8suQc3u/iEH8ZNRJre7yVw5Gtaus2jiaanRXKO5g
	 HihAKegOhR/tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bird@lzu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	tanyuan98@outlook.com,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y] mpls: add seqcount to protect the platform_label{,s} pair
Date: Fri, 27 Nov 2026 12:00:54 -0500
Message-ID: <2026-11-26-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125192225.48048-1-artem@trailofbits.com>
References: <20261125192225.48048-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
> an inconsistent view of platform_labels vs platform_label in case of a
> concurrent resize (resize_platform_label_table, under
> platform_mutex). This can lead to OOB accesses.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
