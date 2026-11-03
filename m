Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713004;
	b=LSLHrqCV5QGbZSHScsDz0B97J/hqjqIYN+y/8ohGLhLp6yBSUNFRhLE6S5BqnRRZZvqh
	 KL+FE9Bav5H/Krmah+owAHr59be3v+H74qbcciQaqJpt6oDMwVnAmqjSLvQ5gdzuemtn/
	 hkuB8znQJihlhc3jL3LRmKMAGd5rq8RxofA8ftqQnsqy6nSwqdij3sNs/tfZGeyUCK52O
	 ZvYxCxGyvW1wJ33Of7fHYwikqyC07hxuxUljjqzE8AsH8t6C3Wy7y5KY/BXrR8QU4mCOq
	 4tv/U7ngwmmNJlZd/z8qWT1reerFtY/+GMzHBL1Si5I5+kQa4hBfcuPDkezkah5L2iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
	b=ujYmr/Fvcu2Zdmylr+mDPJ6FH7Q/q5jcO0AdWfmAbqh28s1uiOxlPK4csFexHuWlZNQi
	 BfdMGYZznf3bR2dtJq+IjaidiNx0CgmZyYQGUUuABLxpckAmf8YT4N18+jSFzm/d3cPvr
	 q8QeWeIK+QFwBV/3rQ39CxGkCZrM8qFUtKNT1UNUXm6PB92mp7wuVi5YlAmDVxFCR5Hzr
	 QuHEA5mgQly0ln9XvhxEU3NoF77GZVm+4j2G3p4AZMh8HszQIohy+oaGOHNwFERa9WXFZ
	 5WpaCShB1EQ68LP1XBIBZ05mHbBcN9gNzgFvQF1L6QvoymH0qq70GpZtnyF2Lw8ZqNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+2Z1fmo;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B0606A336
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 991B0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+2Z1fmo
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae18eb9b69so3064367c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713004; x=1794317804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
        b=E+2Z1fmoNcTkqQ3th537OvfMIa4NZoYHdDl7AVRl84h1LYzeHaZpFZScTVrFJBqkUK
         JIJ/AbsyeaWadb5t+w6s0Bh/Y5hVYZfbe2skMnsh+AXAXusS2QBCSSK9hqOlg0IjHdgK
         LDbNgo7Ll4jU5lZorxqjvTjexd1LRDt5PZ0v1OwhGMJXJJ/xZUzmcIRFrbB44HC/oMru
         k98sXmmyt5kMVnyH7gDOB6vYbeKQsXoxeEJsDFgpw6MLPknjE3lWjzl1d9o8+2VcNs6D
         fvidzrs4P10T4tT6hJVo+Td3dstpl7kKauv4j8nJu4CV6oyIOTNxXuH9XJXINSq+EHpt
         GILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713004; x=1794317804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
        b=hFQLcTAg6ZTdd89wtaWQIX9LS98l96cyiUTZYP9Q1SYxNxSm0M9h93cDVZJWDMzeoq
         ZaadVfN7jXmf9PVCcOjkL2TXm1fg2VvkocGPDih2pWu6QP22uIZ6Fu5zoTau/LPgNMF7
         uZK0azsaGqRe2m/dDUkbc+FKEBT+zljewwKGDgJrQfFBChknyH0qx7R7cGxLCyffyQGT
         AkOzg8te96ZMYU4imcjVBi2y2siOpAhO49LH65j62xz6UrTpJMQ55oUI/I8M3efYkW00
         GPuNdBw6kvnMHHC/LvGYR/8TQqiuEWz+fSOiPCgTLhl2/MEuL8Rm4skUEtAlhtHNfw5u
         HqHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvBZgYRN2ieCVDxjI6+blvMpC5LFp8jo5RiyVfKkO3KkwhCktmsD+WFgeGlUMiHJ1DRTtycPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+SqwJ1Utzj/1Q6rZLPcTTl0bJWR8uAripi9lc/+M6tUliF2rW
	tgSJ9okxPEkD0mA6x010z9Wy2NlilI7pzlbcU26/lsLdbhiBaI5yznBN
X-Gm-Gg: AYBFou0DV5u8qblAngJtzDMwOscJFKvDs30QSTR/Gf023r9p0i4hdiUnl4SM8mYY/I1
	oyD+Aeadq9ivcN2AXGJdnOIGMNEp37QgFjkwea1/sj0Zb4aR5c9NCTGZbhjayUOeA0UjyrCIXcW
	MH8qlaqcxJLPetbh7tpX5LB281prJphLOV6Y1xXiWP+8XBhH7A0xUwlY+lAuNMekf5pGqBAd2UB
	bPNOXucTGz4IKDcE1HlmtDPRrNBI9fjZne8owmPTmZpvc+w0Q/zvzomosGdSsoHSVXeh8w6mbAY
	51lr7JdC3HYmqIQOO3gIarUIBQjcchMP6zg2g4DtwUV0nhO3nZC5eq5eMWRt1fAM+1gtj+obIn8
	hUekHKzz9PG7SwzlBzX7xr5FsxkZFtIT01uMT29uUrkn/SVIw7PqzhFeh1hSmTF7gQpZnyOF6FV
	MMsyknqUOOkU3KI2TsWGn6iXDeluy3IV+AFmo3iVQDV95WScwcnNvlaXwNhZ2sPlo5FDCxYRPFx
	YH516xAfIOaJSMwzAx6ncV/P4QcbRqMZTrHZt+lzG6K4+SPgHqOc0t/tCF70rL8Gioor+MpB40R
	jcKNZON6fUedpNc+FG0CmPvavFwVbjCuSXC7+pN3dptDAbKfn/EFbv0K69X4RiNj6w==
X-Received: by 2002:a05:701b:4283:10b0:166:f097:6f12 with SMTP id a92af1059eb24-1ac5cb1a303mr20255880c88.15.1793713003679;
        Tue, 03 Nov 2026 05:36:43 -0800 (PST)
Received: from arpith-debian ([2402:3a80:40d:48cf:34b0:c816:2853:c60c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm73904112c88.10.2026.11.03.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:36:42 -0800 (PST)
From: Arpith Alexander <arpith99@gmail.com>
To: liuwb@xiaopeng.com
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	lixu.zhang@intel.com,
	sakari.ailus@linux.intel.com,
	stable@vger.kernel.org,
	wentong.wu@intel.com
Subject: Re: [PATCH v2] spi: ljca: validate the response length before copying the data
Date: Tue,  3 Nov 2026 19:06:08 +0530
Message-ID: <20261103133608.29246-1-arpith99@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013031717.3933277-1-liuwb@xiaopeng.com>
References: <20261013031717.3933277-1-liuwb@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 11:17:17 +0800, Weibin Liu wrote:
> Check that the response carries the full header before reading
> r_packet->len, then reject responses whose payload is not contained in
> the data received or is longer than the requested transfer.

This breaks SPI writes on a Dell XPS 13 9340: the LJCA acks a write with
only the packet header (len = bytes written, no payload), so every write
now fails with -EIO and the IVSC behind it no longer initialises.

Fix posted here:
https://lore.kernel.org/linux-spi/20261103131435.21838-1-arpith99@gmail.com/
