Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478819;
	b=gq64/tNCBZd05IzsIx5gsw3Y2RQnpqzBNhLV899UV8//+xV5H87flbuipIPoBQ7n2gSd
	 0JfqJMURVJpcLn9IfK7tbt6/jaNecpWv8Sq/8jNj7Bz/yg1zXCi/JhfMnoiEZAhYIHRMZ
	 ugfSYV9cmpuK18D+XXsvJi+BQ1KRFTz0QEDOZAseC+tEx+cxtMdQNpYCBwvLxfs5JCm4p
	 h32ydLvhxq/hFRqKZ6H0kgIrkGM5FZmH37XT3YmBPQUGxLf/SVUkfvcOFPfFbgAiCBDZJ
	 +BQNshHQTZcwR8e1zbLvKTCXhs+EpORxzxcN+Rc8Ipl12v7iTDp/cSW39RyyS3xQ9SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478819;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RIWag5OiJhTtLBTo3JY/WRR8ZO4h9xWnLfyk2+s6cm8=;
	b=LwOQqceiOaENvuRooLfFcU344TjTqD3J/3acB1DX0wum+WO71MMhOeeo0Ppo8NNyEIzk
	 JyXZyO+KqpIzW8GBYMvHYWlqY95zD7EMD4JlpnWDDI0qUQFk3Tg6NZI01WdvTq6hFD/HS
	 15FXZdoj8z5sJdW+6M8XlH9OBkw8CKl29xzZ7iUF9Fgo9nGVM2W8eoBQ3TRnUccIafyFj
	 Tz3xFHobNR79KIiExTYm81677H/m8TmiFVYcZxDjIVtzzLRsoGzq6MubwPaYfGc9+yHqL
	 elYkhJ06qd1tWv4WkV+yMWJb3JyFV5aqcRiN2xym/rOMETAcUnVj6rWhU+4JTAZG4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Lm6QF7Sm;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26E606A326;
	Sat, 31 Oct 2026 20:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D26E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Lm6QF7Sm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RIWag5OiJhTtLBTo3JY/WRR8ZO4h9xWnLfyk2+s6cm8=; b=Lm6QF7Sm2VEHfKCsNAMMRykqZu
	eC/OsvSibVHYKRKxkZ2nS6uynT7gjgIUtU497uLg5qIsTV3BHQ4j/w0/A4Luoxd5cY0qRnpBUAk9o
	phMntR9M7m2CGFBMSylgyDEImmtqHhZEp2uTHs1hs9eRyX5N2CXLpA3fJXdZP2dB4md0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNFlW-00DZL9-C2; Sat, 31 Oct 2026 21:33:26 +0100
Date: Sat, 31 Oct 2026 21:33:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop
 phylink
Message-ID: <e71cccdf-59e5-407c-b536-9dd47a49b0a7@lunn.ch>
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>

> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")

I asked why you picked this Fixes: tag. Did you reply?

  Andrew
