Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE96361DD5
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681649; cv=none; b=ZcTpQMHjwLfX5JpnOabhA/cqjKPp0NWj3I99bsY9OsnnWrXwkXhP1Rnt5Ky1awkDbTNVHDtzi/IZMFWQBU9xcDUq3aqOakO8n4/1MDMRNFqMegLbt6TzvKWJcxiVDPbeLopkTYY6XrNrRB25DOnEfDkCe+1jApI44Ugrmf7+P94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681649; c=relaxed/simple;
	bh=r9W8pxX2upZvPqMU+HVOraS2h0Gzb5i1okUR78EX+o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB3+r2O5vAmnZ1Rfg8Y8siurnBnXCa2lHME60TQGk4TBygzJs+LF4PoVvyB3g74GEW4k1cthvu68qlIvmy7HGggZXTeAwBF6b0Ih3hGzTsiuMF3HI1ACEZa61xc3MncEPIQll9QrVzYjm4sm04tkof8MKhmfSbZpmD6LbLNGxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i11lV3Ed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i11lV3Ed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156A91F00A3F;
	Wed, 22 Jul 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681644;
	bh=SeKpOL7ViQH/nobd7lgRyxBmmpb594VzwV3gtumA6AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i11lV3EdnXF4ScA1N4KiawM567ivfpcg7mYi1L7Q/9Lk5LWX0x8Yc/TZTpqzzIkyo
	 9YckQLEB9r96HFSj8WJ9NKpSzTmaYGA+DCTFBFy1zIxsq/eOqHRhSILHFhjZwTD74w
	 0zB37mknQOaXz6A5C1pBkRWiL7dHIpmlgCAYVV4wPXtCSuqueD0wjXav/VZmxhYQBx
	 GAZa1vakyekKkzDIbfKzTr30nEzJ7nRLH03vy2IIvyBR8RtRlh4hGzpNYcUxW41hUy
	 NCH29E+tdi8h1jtS9LSyhwKl+v3p0qIuPqai6Zj0O5LMVwOdQ0Ga5BAf3UvDRmTrub
	 DCeeS2/OWam2g==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC: How to backport 920f893f735e ("posix-cpu-timers: Prevent UAF caused by non-leader exec() race") down to 5.15.y?
Date: Tue, 21 Jul 2026 20:53:50 -0400
Message-ID: <20260721201114.0003-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072148-saggy-broken-3ee6@gregkh>
References: <alVfR78eqdaRbOIy@eldamar.lan> <2026072148-saggy-broken-3ee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > At least that would apply cleanly (though not yet even compile tested)
> > to 7.1.y and 6.18.y but then already not anymore to 6.12.y, which will
> > need more adjustments.
>
> These look sane, I've queued them up now, thanks!

Queued the pair for 6.18 as well, thanks.

-- 
Thanks,
Sasha
