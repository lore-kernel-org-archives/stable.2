Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF633DD51C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474565; cv=none; b=gIqBeYb5+YUkZEZIB9ZOvNEBhurJI0I3wEM6ISLG7Z74cb1g5w1bxRoUf9q0Y31TK0UvQPiRKYWw1rcLr625LBou1EyrGKFCPi0LE9rzJbN4lsru7yVEoqMnqjeA4TITWMuAUyCJZxbjAm41MdhiH76Chf47krK12OrgZQD2hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474565; c=relaxed/simple;
	bh=+1Em5sKTo95X4Dt1FgmlL0gHWbv2SZFBhTHvuNwKLtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4esQPDW7TA3WWs2wRIlyqTsubqr2nwHxjIVqIWDxg451Yd2atxv/stLFPzbrgFrJ1aOzlzINfTqmgnXxEQYnloOKFnh0yEm2sbxvDlwZCfR1ysI0W7/L8fpy0Zqv9QXGOsQ1zmQeML0VZJ/N176/16ETgiQc/kcTLs1adgPiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2CfpiLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2CfpiLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F711F00A3D;
	Tue, 11 Aug 2026 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474564;
	bh=MKSRBtkf6XoVOYnw27sFT/8ZIXV3gaJEhOjctj6+Ryw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2CfpiLcIZdBdH7I3VZ7/0nT65c0haG7pxTOhlTVrEQ4Xm6yKphL6EncQTHE0zYeu
	 mhDgk6Hs0ZDaCBIO6QxtRKTJ25MGFoqqVp1DZduRt7UMjKnUove904epZoBwi/v27q
	 qOXxiTLVjniQEBxGS6U2FMyroo6kivB+JkjY+ERpGvXFql77JPJTRrAn7697+QHckc
	 Yv3XkqH/RuA19ydWGa2G8VzOB5FzzzvR8zzlpXpEXPjvLWRUg8QzpS4Xfh6wBaEAZ2
	 uRJM/HxwifOpiAWGGoYQd0ZheyMpM5AxlUPYW4oPSagedX9Gq/k5j0pvrm2IqT3SP6
	 vp587qMyq0V6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 5.15.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Tue, 11 Aug 2026 14:55:49 -0400
Message-ID: <20260811184500.stable-0004-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810134012.364362-1-dengler@linux.ibm.com>
References: <20260810134012.364362-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Extend the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
