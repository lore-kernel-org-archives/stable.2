Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF724389115
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422982; cv=none; b=aC9N3AVz74GiffrM378AYEgo4IdjeLSThL+bgJ2Set5qK4JclIKU/RIcYuUzMlH/ard67EcvOLHmjwsrJkyUIPO0iXjiR6/seQJYFzgV5vrrsqA0Vxw49NfiAJKuqI0mSXqL1QIn9wnC7Aj/jRBKO8T2W32Tgp5Z5fH5di9jBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422982; c=relaxed/simple;
	bh=wddQWovUxe2uKJyvwdvKzdgZhQJpx+9myOGJmM3ZFx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOPnr3aXyommJp74Dcegvgso82RkPgszX4VmVL9fDsU+umuVO59vPCmn4hAkdg0FYlXLpE5BBp8TjshLiIiSf0T/vzjKR17lGrI54sG7laMeAR3fXPyin5Bv9wH28mhM4ctlJ3KQofPyd9t0XyIL3+UInsIayAj+52otIGuJXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQga4iYN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQga4iYN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1387804a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788422979; x=1789027779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wddQWovUxe2uKJyvwdvKzdgZhQJpx+9myOGJmM3ZFx4=;
        b=YQga4iYNatyLZQjJHgBJzVK0jpXBhAFsGsc4tFC/2UpSo2cZi09jPMGO5YbwniO7Rg
         62iUyWA9BLCoozK/yDQNhecoNINgh4Aed4+4JMgPs/WYjQ03/NMA+/1yi9YWyJpp8uA9
         icspvsiZ6ZIz36xylflmddcZ3galj7v1gGDiObSn0adgPv62PsxUWwNyr7llxS+Ys8Be
         mpRzaT8MUUk2fpuMBsJRvNkqf7bqi4z/NxbNSATall4k+wndGQyp0FMi0KZiubM7eEZS
         aIVeA16HbmqoTML9FtmiW4uOMu+J3ipcTNiM/uvJf5kdjZ0qTcHwKzgaV4k0fI1Sk/NN
         KJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422979; x=1789027779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wddQWovUxe2uKJyvwdvKzdgZhQJpx+9myOGJmM3ZFx4=;
        b=VDkwoKg2tQ5XCux15gigmmV4rEr2sQbJhTUPaApCkYPTo36OZwkR2ecTurl73BlM9C
         Xj5vFIVXkz6KRhGmw1OHGfaEU8rKt9/MsdX+CDDpofP6F+TIzO/X8009PJCNY0xGHKQ+
         KWa6o18HZ4BUhCTA4BWyXKBhckakl9vlFqJBkricz+Fagxi9RCHMCELOXQq7p14i/DUo
         m+yPbV8IjEy6fmH8PveNykFyhjeS4WRlFcvkvno/otLNh4jjamPikZxo+MklgejIOUmL
         9Lvh10LXdNocVXPqnXGOdPiu6AlGSVRdfk9HGqenvvxb73NqI1HT5ZHGqaN/HDS4Epwb
         a5bg==
X-Forwarded-Encrypted: i=1; AKwUvBzw0SJ32itwIRjrW3thPXwQVE7Aj4AG+YlePEr32ayqkKTo3V5Ftk/OGRRxgUXT7AgqT74SupQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nCzKMvcc2HLHB7y6MRjHuNIHwfMnuXY3ZkKmHYOSJxxfSzKT6I
	E1TBszcCDDRpB0MYqHL2ewG5SaRA8drU3hh3TY+/5oyIG1vvgVXeHn1y
X-Gm-Gg: AYBFou0u2T/BMC5ayJ8guDubMMi9n1/72/V2grY3bGza63ysiV+9xx0SGUqW+LoLtZA
	LJSH8NdRljsWdetOTpyvPMu9w0JHSgrcW7tFZC9v9GJ65HZ9poD+2yLerU3m+gyoZqYjq0h4kRx
	zRA6iyhsQNqny1tigNRPndkxzyXxrdL2y7el0wFbF1Nso/NOsLksNVjF4TgsIMyOx77VP8K0ZeV
	BQC7LGaGpjiYc/1zKkKug4s2VMEuYdI/KOVkgzESV5GXSjsEaOWsIJfDeayA07iNj1pChsofxFb
	lRK/Kr0kwszVT1clq22nYi9toSjq2YxzeQ7A69SshOpWUq8a3vI6TmI3AtnvL4/+/uNKxCW4/Ua
	h03w/CbLT0dZ/FeNsHewlUcia4JBI2ahpTRogrdu8P3zZ6bhDJ3f9nAWv9KC0pTTAtqrpSt658s
	nDSAnwRlhz9R1sWBA+gYaTAgfv5S/8nOpAmeWv69eBBT1W9oTfl81owD5C93/A1U82iqH4+hPhZ
	MigVWHe+PZu5f2NbIAKQdo3zHPhc70Je2hsYf13CkltOu681w==
X-Received: by 2002:a17:90b:3f84:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39aedf1922dmr16176799a91.6.1788422979169;
        Thu, 03 Sep 2026 01:09:39 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.244.59.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b087b59a0sm4004345a91.17.2026.09.03.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:09:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: reject duplicate wiphy cipher suite entries
Date: Thu,  3 Sep 2026 16:09:32 +0800
Message-ID: <20260903080932.92286-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831133314.4125787-367-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org> <20260831133314.4125787-367-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 09:26:35AM -0400, Sasha Levin wrote:
> [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: reject duplicate wiphy cipher suite entries

ACK for 6.18.y and 6.12.y.

I'm the author of the upstream commit. This AUTOSEL backport matches
7187d145d904, which has been in mainline since v7.2-rc1.

The change is a small wiphy_register() sanity check: reject duplicate
cipher suite entries, and reject n_cipher_suites > 0 with a NULL
cipher_suites pointer. Duplicate WEP entries can overflow the fixed
iw_range::encoding_size array in cfg80211_wext_giwrange(). In-tree
drivers already advertise unique cipher lists, so this should not
affect legitimate hardware.

Johannes preferred this over adding a bounds check in the WEXT compat
path, which is why the fix lives in core.c rather than wext-compat.c.

Acked-by: Yuqi Xu <xuyuqiabc@gmail.com>
