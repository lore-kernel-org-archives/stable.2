Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AA3B6361
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541097; cv=none; b=LcjeStDpLLC64oAoGpo1SQ3ESugq4sXGmKYmkY0uLGVtIDZ3xT5XBZmZ4byvtbERVo/gOgngG/SOV/77cI+4apr3n+ZL3z3yyb/KCPJ32GXuli+cliJmSST3vJZXS3ufnJQ1DbM0pH3pOobMwDlKMfBztQ/X9+6njlrrk2NuwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541097; c=relaxed/simple;
	bh=ECmiUnCsuf0PP00J9EUGstc34FNcT446eF3bYmlaxYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoyB6gMTGEV1JEGo0fL+SBJ+52/v9jHIqBR2UksfETgWAynoqh5X6THeENYQBOX+83DcKArjAvWX4rnbuif8eMV7SI90vdg9oRhB//C6W0nAQ+XcNusgyxDwVtoubZhjd++glTSibFSacpcE6RkDZLdCBzSCSNpX8CAXONFoJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejo0Nd8v; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejo0Nd8v"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e529da9so708054e0c.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541094; x=1791145894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Kdmoy3jfQwTDOQRMgPKKjPEVV/7jynijwAv/AC0y/g=;
        b=ejo0Nd8vrfYyvQblTil0BstYx261CRb+jG81/UKhP3T6sut+b7yWhwFoUVcX15ER0n
         TYT+MCniXAyUI4LaBzRTsMSJwnatR7QgEfK1RMrh3jlEaE33dJ8iI3w4szBpEsM39Z0G
         iPjYwnRHBuQobFsl8HTEz5CmwV6y0zCqMANcqnNN+qzuO6b5l0YKDJykXz9dE/Xiu1yL
         yHC9kFf8KgD9aBgg0jyWP2sGgmYKKU55V0GIQZw2Ogq5uFBteENJLZQWC2lt4/KjliNe
         NpOmA5pg9OLNP0kda9QJzU4Hir3s2AXQyfglLn5KY3nEgcvMx7tnv0CW2GQ2ItxboksL
         hCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541094; x=1791145894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Kdmoy3jfQwTDOQRMgPKKjPEVV/7jynijwAv/AC0y/g=;
        b=TRKuPxW+xBjelEb62/OnYVVw/MKMt0odXV+5783eUOgpSpXEbB2QYEz9KgMjL+l2cd
         jlLjKfYMo9gRX1u/ku+1zqkXwlGfzkrQ58pQDhkbKwqmdvBO8p2coKwWfQF9zGCO5Ezk
         /wazktqGsWKgY+++I0r49gu+/MkqJ4MwHXSmTkjKovJ0uz5Onxpw8dCWEVt6z7+Yi4Nb
         kWppaL8Pmqkvn5kFbPIL3VK7F/u+3UFq4j0NTDF11BCTZSRW0sOIwttHSY7KoV3lH+Vd
         bZnIAXzRdjxKCsNKzRaVK6SYulkfMtiy8OL9R/kA4rPTAd5J4XUR3EwF9Ft50MTWQkJv
         aWZA==
X-Forwarded-Encrypted: i=1; AKwUvBx/AN1KFh1o/MImiP+Rjp1LxU7hxgQznCiVagnNpLstAqH2jTqur4Zmul4CWTboOkZCO+8aTfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7FiscAo+vDRFVBtaH11Wzr4o23relqOGfVdOhRYuaKZcXH+Z5
	aKthStIySR3FCNozmmOWNcqHeBKkYtKM7VsXmkzKzBLSoSpqy14Dooml
X-Gm-Gg: AYBFou3cWOZSQLmEzR8fVqDkoTf1wKRelqbBS6nlkWwgVhQ/QDUoshpyT5DaujRmFEV
	BTO2svp6yDMfZMa4ElKt8HZaPzOF/D0PouOKz4Zl/9tcfQbohejwLmaXPLbnWhGHEjmJRZUNkW8
	ZKVr/W2nRpaZvO6jfRrTjnoih+uXhnmmLAqz8mzWGswEInz+iJnp854gG/KKjXhBsOu0WLddH7X
	WCyH0LZMCmyx3HgU8ItVYJ7FqwYKN7soHsAYCWCdzWZaM8pcRb564YwpN6NUxWXGIlv4lr7Tj05
	5nMl6CJoBMTQgJ6YRO+es1No58RCXV1rNJpwVLUKOK/uB+UEjEuaEY82vcba0BLaIzISJWTH/y4
	UilolksoUblgMCpBRcVc2TpxCdbnHvxAjnIUYTFL50G/JNr9okALBK3LDn8mJSts2l/Po/FrdaI
	QZcn56Wy533Qs3Ur6H8Gsl7GgJLYw+Anfkv5CBfJ2OkA0Z73MopVOOyfM2NTfItsE=
X-Received: by 2002:a05:6122:3d10:b0:5c9:a618:bbf7 with SMTP id 71dfb90a1353d-5cb0c628f53mr4928551e0c.23.1790541094465;
        Sun, 27 Sep 2026 13:31:34 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde4f99222sm6419782e0c.4.2026.09.27.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:31:33 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: johan@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v4 1/2] debugfs: fix use-after-free in debugfs_read_file_str()
Date: Sun, 27 Sep 2026 17:31:24 -0300
Message-ID: <20260927203124.2060754-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092720-sandblast-heroism-30c8@gregkh>
References: <2026092720-sandblast-heroism-30c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 27, 2026 at 06:37:40PM +0200, Greg Kroah-Hartman wrote:
> Please don't use a LLM to write a changelog text without crediting it :(

To clarify, I did use Claude Code during the process, but only as an
additional reviewer for spelling and grammar, minor rewording, formatting,
and as a sanity check for obvious mistakes.
I wrote the patch and changelog myself, and the technical analysis,
implementation, KASAN testing, reproducer, and verification were all done
by me.
I should have been clearer about that when you asked earlier, apologies.
Given that limited use, would you still prefer that I add an Assisted-by
tag for the LLM in v5?

My background is security research -- I spend most of my time auditing
code for memory safety issues and race conditions, among other things,
which is how I ended up looking at this code after sashiko flagged the
missing RCU protection.

> This is probably not right, don't do loops like this.  Either fail or
> succeed, don't loop.

Agreed.  I'll follow Danilo's guidance from [1] and keep the
implementation simple -- single allocation with GFP_NOWAIT, no retry.

> Again, let's see the real use case here, what is hitting this in
> userspace today and what debugfs kernel files are causing it?

The writable callers in mainline are:

  drivers/interconnect/debugfs-client.c  src_node/dst_node (0600)
  drivers/soundwire/debugfs.c            firmware_file (0200)

I am not aware of this being hit in the field.  The race exists
because the write path uses synchronize_rcu() + kfree() but the
read path does not hold rcu_read_lock().

[1] https://lore.kernel.org/driver-core/DLPDB44JJRGJ.3K6JNS746M7QC@kernel.org/

thanks,
Aldo
