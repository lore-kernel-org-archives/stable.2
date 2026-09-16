Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7637BE75;
	Wed, 16 Sep 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601114; cv=none; b=InnYq835VLNdf0VH3KbYvJewn2XA8zoFBMXud1AO9exdQyXUGuYCM3y/gImeLCbmwiFP3ZQ+5nxiQNptp9QVNApK7vDrm0MASj5+TROtVc8hC3OMRquYKWPtnVmITaehS5xfHxbSodw3FmJOIOEjJZpJH4V57Uhb1SCyblIaHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601114; c=relaxed/simple;
	bh=dpxRaKomOgYQOFDdhOiZvN28wNyECU55UPVOVakvXOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObXd8fa8dvU0WbKUnKgHgLUWUHdU23UF8Rn13cFB3k7uWCYlt989P914pQFtR1v1D7lPuaLP2Bw1IULiHqMmP8VuWd2xVNPkH89bKwNQKimb0obM/BAj4owRIfVFpe/64W1ITnP38x6LLfN5gHSPl2m0qA1PbsCK0pnGb75pJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=YS3/nrJE; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="YS3/nrJE"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 102D93D815C0;
	Wed, 16 Sep 2026 19:19:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id OqeLlMrvr1Tp; Wed, 16 Sep 2026 19:19:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 42E923D81784;
	Wed, 16 Sep 2026 19:19:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 42E923D81784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1789600781; bh=h+vrNHjDFH3BleBMVZsBLVFryjoMLJgk0xB4KKR8Ovo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=YS3/nrJEc1ISRwbvKbN9UcMnmwMjy1Uu+RtAJjqNhlIKiyIF+VZfu/ynr0V5gBu/9
	 NlWII6QdwYa4HefeIv1m9IQLHhhVw3yW0v9eqOkPW/ICEHiDJpfKqfm52fbEeWnDIf
	 mkpvgJq31HGqBgdby4O+RNepoJR9VDDFnGW3gpGLmKNuHspUgEgPjMp9/wUlpmMeCs
	 YndNiQA8pIXv7mTsMoXFkrsU8ztM5NpwMYhDxyK5xivrJoQkRQk17fB6ZlRPsFPwUw
	 pATnEjeYsTHUTcBAkeeYfn7TV9V7wfDFRP4D4yBuM20fxVi/X3RuQuhGJhQCeGfWX/
	 7tH8JXd1HizDQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vkdFdstcDByy; Wed, 16 Sep 2026 19:19:41 -0400 (EDT)
Received: from aojha-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F11233D815C0;
	Wed, 16 Sep 2026 19:19:40 -0400 (EDT)
From: Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	horatiu.vultur@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: micrel: Advance register data pointer in write loop
Date: Wed, 16 Sep 2026 19:19:28 -0400
Message-ID: <20260916231928.1336305-1-abhishek.ojha@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

lanphy_write_reg_data() does not advance the data pointer while iterating
over the register table. As a result, it writes the first entry num times
and leaves the remaining errata registers unconfigured.

Single-entry tables are unaffected, but tables with multiple entries
leave every entry after the first unapplied.

Advance the data pointer after each successful write so every table entry
is applied in order.

Fixes: c8732e933925 ("net: phy: micrel: lan8842 errata")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ae830781824b..5c8461db7b4b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -6344,6 +6344,7 @@ static int lanphy_write_reg_data(struct phy_device =
*phydev,
 					    data->val);
 		if (ret)
 			break;
+		data++;
 	}
=20
 	return ret;
--=20
2.43.0

