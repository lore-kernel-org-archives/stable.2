Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02D219A8A;
	Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=JP+j3d6Czplg/QvJ32wSad+ornfB04U4ZXGp/3hJUOnIB7lcQ6l8Ewx1zkfO5cFan16pxssghsdGce3DmyldLjLCm4mgSujNncgrIsFuAtNhgqoM/km4Q+ZESBxo00qYH3hGLFFtIzAXoSmtnUj/+Q+JfiEJyRmhCsmi6E9NCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=75GYiiCJml/IjuqDXcFZdCtlD1QjDgbuAoiVD6MVm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnsIRzsnjS32KcHPQ7l/jm4LQdOrv6WhIzNlpEgqdBWmjA0pSlgJyO7kHstqZFH5Sz/IxHe64odNu6qtbYPFGkQx9tcJrZmlwNOaDr99KayKJ4ZQyRbCAjXZQjT5OSg17X3Uxcc4hmZf9V8iLfavRNX0PhgG6XsNiNpv+LjWr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4crrjwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4crrjwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BFE1F00899;
	Thu, 11 Jun 2026 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138741;
	bh=75GYiiCJml/IjuqDXcFZdCtlD1QjDgbuAoiVD6MVm3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4crrjwNWrRttTx1gI189T+dtVD/Jf1hTjf/xUSZwY00s1CYzR8hS/OoWZtF2rJYU
	 vDMle6JnZzzNwzsmWHEghJsOD+Rl+OOs3JsOxyacs5Mw88hk3qeNrpIvcvpvRP87nT
	 rAFSqNbY2REBCUjuqvy0DB2KXkVaYGGnZW+Lq/ykIQrkvWofCFkwpT+ROM0B5uUfUO
	 Y5OeBC1ernA+Q9njF72Gn8NwiTnYgZO0iwlniPVMaq/N28GHOoO02hcmVjrdmg2O+5
	 ksaq66SJeYjl2AypfbRFpfC73eNn27fIRVvYnsayqNVa4x1/gymxtngFKwi1+DgDDE
	 5sYIx7vrKnE3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5.10] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Wed, 10 Jun 2026 20:45:23 -0400
Message-ID: <20260610-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609181108.29138-1-apanov@astralinux.ru>
References: <20260609181108.29138-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2026 at 09:11:08PM +0300, Alexey Panov wrote:
> [PATCH 5.10] wifi: mac80211: check tdls flag in ieee80211_tdls_oper

Queued for 5.10, thanks.

--
Thanks,
Sasha
