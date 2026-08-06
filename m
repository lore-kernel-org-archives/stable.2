Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570846EC77;
	Thu,  6 Aug 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016203; cv=none; b=TQ6z4zaur/UrlBXEiIkZ10N6Qd45YwQRjun5dEq/K/d+sjqISFSvV7V8o87phl4yl/yq36cabPQJb0N5F+Tt9kXesSY4MY86M0Owg8emt3IWLx2PLgB+Wr3qJWqxL04RXaGC5gUeNEYmcaL/kZdanDo1mWxKzIW3W2Cgzo5LYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016203; c=relaxed/simple;
	bh=hYvaPa2tQSCdBpgqkoZCtwoNxRg/PBwGokRV0EyNMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLctneK8uIOHRfVuNUJYxQhbBk1hSLWUTgRu9Bjsn9kLX96XCO8yQ2/a8St5JrTu3ONs0SjmKrXxqKGGZKx+AyDrxR9f1VFmzPsXAwobs1tq1lZ2ykRH9J3VlF4IrP8nBhd6QszeCGgrkPDCt8AZGR33/48XxdiJG+Ny2HSDNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeYR2JlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeYR2JlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83441F00A3A;
	Thu,  6 Aug 2026 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016197;
	bh=HUTB42mNeKZ7vs+zuZuQhQPjj0Re647kTqJtAh0wki0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeYR2JlIQAlk/dPgQoT5Q3zytxo7mrf2eFCfYl0L12gNNWCBt3fwRyVftFV2ASXOr
	 C182MCa9OlwIVzj8KZkWtBb28JrFmEmWPvmxmM+xEX1OhfHGTmvfUCaiP/IudWx9ox
	 RMluFbQ/FEA2BMfqnTs26gAS9oLYFtzoCU6hK3V2VFPat7TyfPuYu+3DLZkwXuTMH1
	 /hoPm3zZxXkTe9nNbdYoVHvBK5cFUO4LeqTvviuzaO9X+CEyqPE/AuNA/KMgphXjN3
	 vbTEIi8lxaf5ba5WWb8ExxnqzCn1AkNcgnv2yaEpyr5ei45CJ9+cyJJaknnRMWlU/6
	 ncKWhLAuaK9YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
Date: Thu,  6 Aug 2026 07:36:07 -0400
Message-ID: <20260806021809.0014-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805212435.48618-1-tkjos@google.com>
References: <20260805212435.48618-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 09:24:34PM +0000, Todd Kjos wrote:
> Changes in v2:
> - Removed redundant reference on struct sock
> - Removed Change-Id tags

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
