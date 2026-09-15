Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006B3CB568;
	Tue, 15 Sep 2026 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437834; cv=none; b=UBDN4Vhju9nrtHi3hZ4alOJMK17HCoNbQ3moyoF41Po0ZQYojUhYPfx6sOGnwS664zQl7Nik1VywY+5Z2Z/3tpPOjK7v2/6ykeR0PN2BNht9bqTNdrT59PaFZSm80ZqGh2l0dL9uZq5TEGaShxx72bp/LQZuwjOJNPrPd9Ua2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437834; c=relaxed/simple;
	bh=htJX8zq0eNBvNAGAnaIxYHpP3QPQ1wg2KVn3t7UJPMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa+CouFIsraff6zU5LMQKvbv3WLEcvYUg5Aocn0v6SCEQbz9NoAC7o4Vgqr1h/Q3rLZ5X2nZSmQzoITbW62OBxvYpqK2z565bGszYZ+LJ4ued0UjK6yMYBIb+jjueVU3I90T1oC/w8VZ7/JKPHqH0AA+Qi6oHMNVJbCDdJOtZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehajmMgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehajmMgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865471F000FF;
	Tue, 15 Sep 2026 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437833;
	bh=/AF1OjdYB8Y02BTo0S3QVLcdI9H9Acsq3affcJo1PKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ehajmMgJKHtGAKETJ4ld5iESaLECWoRW+KvdWX+6WcRQVTeKWIuhrBQbulQGw/RBF
	 ggErmUq3oQTC777+RLOi4OqKIWbq/BpRxzcsdfZ5agYKqBiOnqoADaeyx8pAgNvzps
	 nOccstwmknfRp+K8I8B/OWHbUuL2RfJ595vTR9C0mfo3MYdRy563aZolRwm0GS/t4E
	 G/CLRnp3AXITKUbbPKDTHc1omF0ZLnkALvj2c/4qRW1Nzy2+NfUGIfI1nLFL45QK0T
	 W/5uTrtOGhWE7aMDOtCtzW/Mj+96j5nhbnR0xGtFlqxh0TSG33L4qcY4g+EBRGUOXy
	 3Bg42Flltxufg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Demidov <roman.demidov.nn@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: Re: [PATCH 5.10] libceph: Reject monmaps advertising zero monitors
Date: Mon, 14 Sep 2026 22:03:29 -0400
Message-ID: <daily-reply-0013-re-libceph-zero-monitors-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914075620.11202-1-roman.demidov.nn@gmail.com>
References: <20260914075620.11202-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch extends a check in ceph_monmap_decode() to also reject
> arriving mon_maps with num_mon == 0 rather than only with
> num_mon > CEPH_MAX_MON.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
