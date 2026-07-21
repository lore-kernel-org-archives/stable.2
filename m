Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAF1E531;
	Tue, 21 Jul 2026 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612037; cv=none; b=tBw++WyBTPiXE5elj//g6CQmmpl+tnJmBJMUXMQR61c0V45T6aFexVTUNf7c538FFKfxJiliphMbllGXvc/VslUma5KyFKV6HHx7d2umDavQHdu1DY194m8HNxJJGJy6bZfMuLYGf0QE/wTu3YGQ+7SDCv9Mk4IfwwUmwH/VVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612037; c=relaxed/simple;
	bh=AAoMl32jD76NZb36p4TQXqWk5Xi9GmrTh4bA1VmCAeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4oURACIsQn76HZJ4HkBWUockWQfZrspiunIU9qvtU1DFvKJ5pS8HP1GA2zVmU04UGhkTm/6RHp/XTcLO2bzz8K1pgv4JjuW9hUJBH3580LBoUZ6DoHZPJkvyaJIiexEB3uTkWsBPsgZ2RsuM4SkEX+hfnWpy7IS5tfen83bMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPUOzpdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPUOzpdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ABC1F000E9;
	Tue, 21 Jul 2026 05:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784612036;
	bh=KZf/u45wUTEFkfeKEZteI5f+fagJSbUacPtaoUyhQIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPUOzpdoEUGKZ5IVRut2pH8tG11dVscEmIx0m0Kn/BJhGCtyr7FPCXrLv0UyjMA4g
	 u3lniojy4mrPCfxGv5uEjUCRb8GtNmscupNRlFMNOa0qNO4Z9D5MulKGbfy0RAsUlS
	 1O2fJ3SupvbF5HeWugWy4DKs1dvcPXDWxwKOpq9IBxqj3sQZ6A9kVi5X0oGrZh6wZM
	 LXhSDRqsqyEk/GLx+JU3JvcUbNn9O2AhcBqKXy2FOZ1MAyOL0hHRZxcM11h8d0hhyp
	 R6JEbboO4Z+Tb/jXWM5t0bkv3Pcha28yWzAeJl/DDKOiIYW0NjjT6qXgop3ZsxO5TC
	 vbuPTwLK+wvRA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ronald Warsow <rwarsow@gmx.de>,
	Brett A C Sheffield <bacs@librecast.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>,
	Ron Economos <re@w6rz.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Pavel Machek (CIP)" <pavel@nabladev.com>,
	"Barry K. Nathan" <barryn@pobox.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7.1.y] Linux 7.1.4
Date: Mon, 20 Jul 2026 22:33:46 -0700
Message-ID: <20260721053347.171860-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721053047.170233-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mail was posted by a mistake.  Please ignore.  Sorry for making the noise.


Thanks,
SJ

[...]
