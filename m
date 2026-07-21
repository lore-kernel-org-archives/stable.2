Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97266390CBF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595416; cv=none; b=E26ze9WLqEfpZuUj/LpSuwdokNeqiaEaqGpX3G+APf6NIyoY1TQgn4F08khIKY3Ib+39uSK74bxIQVo9idPzi0M2FoCVV7BJcmOmzGa1o3mCDBZtA2dGlIZr8hgRhqTS2wTaXqq5YKHPr59v7IcmGiDiAb0BCGdlI2b1m0v/dTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595416; c=relaxed/simple;
	bh=n71y6O+KPyqjJI161SCUKOu7K8SHHtcymjvVux/q2yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffW9JLmuj0gxS4kxQnjxBmfGA5zZfAvul7fJNHqaoQp5vgJZwvPrIMILKHN+DE9eQktlG8uauF9yEmHWXCdo7ke23uAA59w3SvRI4uGrMYTq43uduObLcJMO3z7xc7LN1xma2oaj+oYxv9XW4yCwjFPTzBoDfnHt3lWzDhmZBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh/noEyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh/noEyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1498F1F000E9;
	Tue, 21 Jul 2026 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595415;
	bh=F/IVk97m6uAz2778wm8UFACjuJ447BOquCQaOKw1wLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bh/noEyRU6z3sBn0PeePtFDwADuQ78sE0gkqCfjcOo7ywHmJgeUufIJeqzjCuSFbT
	 G4Uh3HtNvsXwD22U6zd8PWrGTDVRZbnzSee50ivJZCsZij4yAb/28Zm1RLYmYyu4RY
	 OEjsr/tO6L2AR7g9rg8b1nmVgBuaJbyqEpaBtA/8OIc2LnNLsaq+4+rqvRB6IX7jwx
	 iMiYQ0T296VlS2lAbTFsUQZ+TYJ9uiHQKYzBxiVnJdHxP1NRVArJm+h8pzlTaFOVI7
	 dJckPqkCXildy3KS5fudqBpqMCu4OUBr2L0P38sYreKvTbjWOGoTyRb6P8NWLjrTwZ
	 xDwQJGElCu6lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.10.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 20:56:30 -0400
Message-ID: <20260720175500.0023-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720134709.650871-1-sven@narfation.org>
References: <20260720134709.650871-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register_netdevice() call will try to clean up the net_device using
> unregister_netdevice_queue() - which only uses the .priv_destructor to
> free private resources. In this situation, .dellink will not be called.

On 5.10 this move regresses normal interface removal: 5.10 still has
the legacy sysfs code, and batadv_softif_destroy_netlink() removes the
mesh kobject via batadv_sysfs_del_meshif() before the untagged VLAN
cleanup (now running from batadv_mesh_free()) gets to
batadv_sysfs_del_vlan(), so every plain "ip link del" hits a kernfs
WARN (a panic under panic_on_warn).

Could you send a v2 for 5.10 that keeps the untagged VLAN destroy in
batadv_softif_destroy_netlink() and only adds the batadv_mesh_free()
fallback for the registration-veto path?

I've queued the 6.12/6.6/6.1/5.15 versions.

-- 
Thanks,
Sasha
