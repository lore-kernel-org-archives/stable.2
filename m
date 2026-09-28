Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C24F4050
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613990; cv=none; b=QKG5CpyZkPMOPxORkDzQylWQhqwWwqeNhw68scmDIdtzTs9OojIAiSh6sOejK/NpJvSRcQXkRsXGrfVUNiUV/2PdsTH05wUxZdf6AtDDqKbtsyvjp7azcn4mNjpw+fy+GjKJo7hLjatKJLPspgEkdo2c5M26o8m2wk7ONmoi0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613990; c=relaxed/simple;
	bh=IqFRzIZx13rGwBqaPzYgGVXKSKsA2v6VsqeDmpAEIJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfX4TQohvAUDeTqCAJ8EDn8fv/xxn1srWuCUpLFuGBN9NO0r6ZLuxxqG7w35pEZosRpZsS90N5mb8DzevoGb44Ud4gp4DKXVYBGtmuhuF2gzTT8Shp8m4Fvu2jbFkqDlmiMqw7a2PzqJyYipga/Lq36XyRD5manCgK4k2Hdsm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVFHjZMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVFHjZMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020201F00893;
	Mon, 28 Sep 2026 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613988;
	bh=C3nom5bLkf5I0bvEvWR34c6/04C5MDrrLot0CB6ied4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVFHjZMIgTag3SzpeMdMyhR9EN60MNy9MKXRBPM3XzKMdSu9GackqZbptcSt7dSY7
	 MXoS0jwn+wzTbtScxmxps60xNlvCNj8jOp/QZsHNFKpUL9wT3ADTnj9kgJlO+cKvMQ
	 J+2HFv44Ih/x4Z2wRGCQUrznTXm1Dd6LG9Wp/hgK0rea+J5Ung5oIAo6Y33RSq70sP
	 FgPk+vXmm6DQAqLtiX1c1BR45Z5EezZSxSriLiXhgOaxaDmNY61qekjbbgynCAhW/l
	 ay+mp0lCcAsC9Txh7vxz/mudoT6EJvLnyKIdR2hHlef4CEZsA6rXJB6dYSahdgROkb
	 HabKsqdcx/yLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH 5.10.y v2 0/3] net: preserve skb_end_offset() in skb_unclone_keeptruesize()
Date: Mon, 28 Sep 2026 12:46:10 -0400
Message-ID: <2026-09-28-daily-reply-0011-re-skb-unclone-keeptruesize-v2-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2022-49142-v2-0-227dee37e858@bootlin.com>
References: <20260928-cve-2022-49142-v2-0-227dee37e858@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I backported two other patches to make the series apply cleanly.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
