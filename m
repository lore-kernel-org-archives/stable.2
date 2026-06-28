Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F977271471
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617629; cv=none; b=OMZhPTKXV7aL7g/2baFYdNs53FPTBr4ay0P6dDW3RKiCvLidhLYoA6mNkTBG7Qz5MRaNcTs2jujiMr/SLJpD2uAz2ygKDpFaW37tUstoSJvbuY6rKftwjS4sO7JAOaHAnmptQoPQQcL6Ci+FwNbiMd4gq1a1KbTBYvojZ88bfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617629; c=relaxed/simple;
	bh=QnvkAfOZVaQn5xyDv9YRDyyQUEF5N8fy/29X8gpx0k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nb9TV2VUeL1OL9FXuEP+Fcevm3KBEqegt02uW1tJD/Ly4HKJRXQU0S0rYsNzE9pdYvpTuZHOj5/GETyRbJhRS0rO1OfD0a3Zr2Alc2gUIRpU/hqL4YXluUvmtyHKPBklHb4Iy+SbSYzmX2fWtcEPK9hv3aXjn5Vrw+vqWc7pKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0v0bqfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0v0bqfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA21F00A3D;
	Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617628;
	bh=QnvkAfOZVaQn5xyDv9YRDyyQUEF5N8fy/29X8gpx0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0v0bqfCb4eFXrCsy50tT2XuO49jQPMjsOl/+t/vr1Jm6RlqIHk5ofyF1sbOQl3j6
	 l4fEH917WuZTCW5FlFifL7KCRfGRe0RAM4ICMX6iDyukLemTwaGZs+nr70joXg5KQn
	 BCPXRQvrbcRqBhGnt7Od4MBA8tvi2pM/giHfiix3U/+0j6m9SfPJIkNrxjlhuL9/S2
	 ObNqdxR5m0FSBQAzSBtpPuOZPJlh+HpGjZYhcsvZ9DeNbmBAv9yQ4mVWngPVZYM7ot
	 cDXEK5vhvaFnBfcWb3Oe6qn7SG1OojVEnvuaeVoBxDDxGX8Wg1TUi0EeAiMaHBf40Z
	 Ka+BXdDAcWTIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.15 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:37 -0400
Message-ID: <20260628032401.0007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:10:39PM +0200, Sven Eckelmann wrote:
> [PATCH 5.15 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 5.15, thanks.

--
Thanks,
Sasha
