Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282952DECD3;
	Sat, 15 Aug 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761226; cv=none; b=H4tE4oMilFFLiQedTmUaGurtt1JE4kdlMOWqRVPofLPiMHLC7mBe2w0pPIf7o2D9276e0Jh3FwFYZEeMTOnZhXqOJBkCeetGeu96cu59ze7IWtiSScdx6FLXj2L4bRAMh18gOwYAErp20/ueQmb0knr6JKP0OC8e5Cmzxbk6NbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761226; c=relaxed/simple;
	bh=vLRoDnNbSv73/vRxLNFdhwGhcAZQpg4yXKkiTGf9vgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgUGfg2CD7hYue9PGhs+ZPjsK6RCFNNjxmnBb847tkyKyK2WXQxe16FKiVcDjfMBpgdJotf6qAqccplEsewCrqxMUJgJjUhWruXQxQyleBf99PxkuEILArZOBKWW3ynv09AeTX+OVW28rNaj8A+Doq+gbbkCcH+JfQCBDibXH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvtcPxPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvtcPxPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E471F00A3D;
	Sat, 15 Aug 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761225;
	bh=XMJH5IhKgbP0GlplaS7HHmpY8/QxgLYD/LHhFyzeqEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvtcPxPNINkzeWKUItregYBeEN9pcU4ZdTl4t2KhmnhqKj0OqXFbTeJBYVu9jcI6P
	 nmFkedCRqNZp7eld+UP5KxKRtv7Kr3V4Vd472dDoUzxxECvphZoimEGsQSZb4QZ4Ou
	 BbKOjDKB3Xb+z40rpT0bCzgrSe2McJR+G2aBliRYpoXPQ1MySrCaLYX/17ROKNAhhF
	 4mcL6aDw0Yer9B5E0dCcNm5F+S2L5aB1fIWvPqxkIwZl0y6JtSSPNP0jYuiDCQgPXu
	 QE9pLS2PE7Cyuv3ksoXxnuCeK+ong98DndN7KPFB63e4fdPwMvBsYoDG58g2FxqCp3
	 hCvLdbfrUt8dQ==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Nils Helmig <nils.helmig@web.de>,
	Alexej Sidorenko <alexej@sidorenko.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Stefan Muraru <muraru.stefaan@gmail.com>
Subject: Re: Please backport two btusb/btrtl commits for RTL8761BU to 7.1.y, 6.18.y, 6.12.y and 6.6.y
Date: Fri, 14 Aug 2026 22:33:18 -0400
Message-ID: <20260814193000.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <em37b1be4a-6bda-427f-a913-4d6e6521e457@gmail.com>
References: <em37b1be4a-6bda-427f-a913-4d6e6521e457@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please pick these two mainline commits into 7.1.y, 6.18.y, 
> 6.12.y and 6.6.y:
>
> bc597f0cc44f ("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV")
> 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended 
> scan")

Queued both for 7.1 and 6.18, thanks.

-- 
Thanks,
Sasha
