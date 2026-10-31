Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470888;
	b=jatLje/oDBW5AAvxRtSF94Hez12R9ccLpp5qsGZJhxKwnWKV+Li4mBHdjorov33RQAiX
	 ztt2jg6JK8UKblXf1nPiIgvL0s+MhMqpuKqiWpXJLU2wsuLz18lk2ZArlsNFAx4GYm5++
	 A5Hun1fU6yGnkGBgBF5Sr5Z8qXGy9SKMiyBdEQToLf1SBk/C+O8FGG3Ep7CniHeYZcUKp
	 HKteochWkJLdD5k9BejL6GqtqRQvxElbDxO9/0oY9a4kDDYssLqTLzH11lGZxvC+HX28f
	 a2Xzbn/D5hvC9LOWYtsLBsUy1/WNDFi1RSe7D8UMAqD7K9+DDsyF5TcDAdFemF/1U+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=lHKFRctLDfXlCv2OU3bCsqyyCRbSpNPu6FlORAWwFwE=;
	b=UI4kfa3xjgDuUC56w2XLG7y12+SWDOZVlIiAv53T4GTy6DV8kL3P7T/byqN7BJ/AJwo+
	 IYM3vp/V1RmvGmJ9JJOewGaubL+xTEvMqVE6anfVLl4aaqVyR45FKJO49JzKtAJeLkjEz
	 hFGi6KxVND/PxccFgFWruB5Cp1J3Y1cUToGpCG8eYLRlgEy0GvEF6Hy0Nc4XSc1GExziI
	 KySi6OKBpampuzc5+QzoQpTmMnR5uwKl0x6jV7rd+xsYqlfRO1EuJ+NvFzynKHrN5M1b9
	 37ihAKiWIraTFOoRN3puFlWEiO4KWwtOl0p5T6yvb2OdX0YP1jmWol074Sct4QQ/LYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTiVZ46j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C18606A31A;
	Sat, 31 Oct 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTiVZ46j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FFF1F000C1;
	Sat, 31 Oct 2026 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793470887;
	bh=lHKFRctLDfXlCv2OU3bCsqyyCRbSpNPu6FlORAWwFwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTiVZ46jpxyLejVCQJV/JU+oCM33Z8pBI4QxA0ZJJUrQRNV/2jfoDvmS4Bz/D4zr7
	 /1ZFLS8neKlXUNFNy3GkEl4V41ArIFXF9PX+y40Ucv6ynGIDV1LjB3buv0RU/A2Nlv
	 LCPtpLDllFhQZVZCkeRBFhGTru/QY1O/0DBZnayzBTN5+GNhs9IFid/0GiaYEtmC40
	 lYPKayUGmUtcHb/LtBlTTjUR9XmFlLTclXORuPBq2UAxDTSc2wRtzY3Y80R1njO6BV
	 liAvZbOsgi99Z3PrY87WENo/G0TFHijqkvWwlnRoctYGRRp0KTS+D0qQfJ1SsfcKS2
	 mljHYemnl3+Pg==
From: William Breathitt Gray <wbg@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Li Youhong <dayou5941@163.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Li Youhong <liyouhong@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Sat, 31 Oct 2026 14:21:19 -0400
Message-ID: <20261031182120.3646747-1-wbg@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <TY3PR01MB1134606C5DE0411FDACBF0001866C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <TY3PR01MB1134606C5DE0411FDACBF0001866C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=wbg@kernel.org; h=from:subject; bh=4jOGApQctKuARm0QUpYj59awkb17qYceby5349anA7c=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnPDLs+zMzxqVJ8LFWoosmlav7pRaBJWszVQw6Vyz9Os z7E6/W7o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjI1kMM/5O+vn3F+Xch75LC 9Wt49nzYfkH9RmJBr/WLxTkMv/xOTrzCyPCO8Xn31u3aV/MFP9xKmbJ4s8qL8wIvXgaWNXN8Fd5 gwMAKAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sat, Oct 31, 2026 at 04:34:32PM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: William Breathitt Gray <wbg@kernel.org>
> > Sent: 31 October 2026 16:29
> > Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
> >
> > On Sat, Oct 31, 2026 at 10:28:13PM +0800, Li Youhong wrote:
> > > From: Li Youhong <liyouhong@kylinos.cn>
> > >
> > > Counter enable takes a runtime PM reference before initialization but
> > > only puts it on disable. Drop the reference if initialization fails.
> > >
> > > Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter
> > > driver")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> > > ---
> > > v2:
> > > - Add Cc: stable@vger.kernel.org.
> > > - v1:
> > > https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.com/
> > >
> > >  drivers/counter/rz-mtu3-cnt.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/counter/rz-mtu3-cnt.c
> > > b/drivers/counter/rz-mtu3-cnt.c index 7bfb6979193c..61fbeb122851
> > > 100644
> > > --- a/drivers/counter/rz-mtu3-cnt.c
> > > +++ b/drivers/counter/rz-mtu3-cnt.c
> > > @@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
> > >  	if (enable) {
> > >  		pm_runtime_get_sync(counter->parent);
> > >  		ret = rz_mtu3_initialize_counter(counter, count->id);
> > > -		if (ret == 0)
> > > -			priv->count_is_enabled[count->id] = true;
> > > +		if (ret < 0) {
> > > +			pm_runtime_put(counter->parent);
> > > +			goto exit;
> > > +		}
> > > +		priv->count_is_enabled[count->id] = true;
> > >  	} else {
> > >  		rz_mtu3_terminate_counter(counter, count->id);
> > >  		priv->count_is_enabled[count->id] = false;
> > > --
> > > 2.25.1
> > >
V> >
> > This patch seems similar to another we're considering for ti-eqep.[^1] In that patch, runtime PM is
> > managed via devm which allows us to remove the explicit PM unwind on failures and have them implicitly
> > handled when the device resource is released. Should we use the same approach for rz-mtu-cnt?
> 
> Here we save power, clock is turned on/off during counter enable/disable.
> On TI case, they enable it during the probe which unnecessarily waste power.
> Even disable case, the clock is on.
> 
> Cheers,
> Biju

I suppose you are right. There is no need to keep the clocks powered if
the counter is disabled because we are no longer counting.

William Breathitt Gray.
