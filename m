Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2F298CC4;
	Sat, 29 Aug 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981551; cv=none; b=jWs/jqXaOU/qitA301lm39vnUvNdn4WfoF5W/5wFBt/RUIjWSXPeRltFmfiQ4t7GdNXoENnrusUdIZodhjwLjTX8pJ2bo3dXgK9cu6K466N5aLiwwzRelwtuaHyIXKjdEk7Bax/J6/5WF4KD3DTmeHi6xFfiIYx2O80BsSHEvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981551; c=relaxed/simple;
	bh=Gf2VGnQ66RnudBR5MwjrWXa+Tg7a0cP4fOJpJzX964g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hLeZQlqsK4vs+Jq16DHqSg81cQgaRAKL1k4dM52NYh15FJw9CywVZ6cYfl0wA0IEGGIlwk73akYL9wGFzh+et8H900VkIDfowMuny1dTs55mVzE2Vv+a+g6E/0ia+JIAL4SPd1E3gUBjaBparq43tdHbodf/TMEKB/KEFcZ+FgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VBac0gXp; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VBac0gXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787981538; bh=uT5VjJfiqLWdyGc+W2u0ru+21BjULfiDjNCFK3lMG4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBac0gXpyi8PJeKM1jPH8pLGklYOuEdkmyoYqm3GEAIKbcfpeDROzk/c0HeTGwXDW
	 jycxV59avDFXwWvcjtrvz4e/F8urAtkpVsHIioraAN8kSIXPb3lsF2+hgXhz8NpyBW
	 ufPNuUHIjDUK3GS88clA243aZJy4YV+XDCxuLREs=
Received: from wang-VMware-Virtual-Platform.localdomain ([42.48.27.17])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 80B3A623; Sat, 29 Aug 2026 13:32:11 +0800
X-QQ-mid: xmsmtpt1787981531tyui8wm1w
Message-ID: <tencent_762005AB7B4F04A2824BBD13EBFFB6CFC607@qq.com>
X-QQ-XMAILINFO: MRBm8gEMwvbCu9iXU3KBdPM1P09mvn9B+JoSaf+LKwa4uBBnulru5tV+GzfF+1
	 nFVFexzi/mI7rTRmuZdNCBCJEvC4q38f3hCsWZWwARycBMnzcXfX7zqROwQnuiWfLbLM/Sdv1Gl2
	 h5m1qJooUCyKbZNir5n52AZZE2qbp6XS8SYDSHGGZ+FvjJRRLZfXX/uxNXkCH5FqbfFZYgILmNXe
	 hhJpNIolNOLyLWa6pdUzc6k+9TI0EhTSpzIvzQcBUgUkgL0SM7OktZLo9urJR73yPjtD2ROOGlBl
	 Vdhwt54AKgITwUWTLTVJVZjwyUWMRG69qwrUn7tC13esVxu4lss1GA515OqpfGi9QsA/x63yZoEZ
	 7TSocVnwEFrG38SuM3SSkJYaW5txMTwMVx3njUW4mR41+Kn8B8QpcW4GPt9nX5pHPtXKs5OYhubI
	 8Bn07y+jwRqo0QmQRH+0yQpBs3jPFuCCZN01t8ePHgJeqIaVVnNPeT5n5WlmXU+Aroxeddh6DEQz
	 kuSX4mSd3PGN/VYMmTNiTsJoBziDJNtdwTBvKYAxWQyB00D35UT0V+fGfGjm4gs4VxB0j3egY4a7
	 zlAJZeSbhJdt4Xt9p35VlZ61OxlmwPN6DvSl7flD+H+w3GCVhRP9q+l9aFXuSzKZVFRJNuRQBcpZ
	 3WkxuARIvqSp9zOAwgYqqXKZCZFC15xZk/yHzJGLbnVQzSIPK8gyeNb+FjtfAgEjT0uGJWs1PNoe
	 Aeo44km/dUqI+0kh2swbbTGfgQuyhb4v7HpYNkgFgwca1RbRGDgy7wd3grBDVq8/kih4/gYI97cB
	 TBfAwteFOA/aNclDiQhH4MmmVLaNVODW6kEfOvCIuQFZ9ptZbLusBNbRgy3CdkcvUMmOg1OGy0GW
	 91YWjfgnFjZVnqA7FF9dAUmXYhWLlfp8v3JF7wG+ynJ4ltYuJQgprkZK7tyydlji7fisksqTd+BD
	 1m/BBY9e4exiPID1kSaBAtoHPWYrHKd9wAS3DSiP4vaMe2HF3xC9igC00fyw/oyANx9HogIabpIK
	 ej+V+5BNPT1c9m4n6r
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Yingjie Wang <1075151112@qq.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: unix: reject negative max_dgram_qlen values
Date: Sat, 29 Aug 2026 13:32:10 +0800
X-OQ-MSGID: <20260829053210.397417-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAVpQUAYOo1hRXD_fFx9oa2bqTV_x17i7Y=vajcx1knYNLjdsQ@mail.gmail.com>
References: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com> <CAAVpQUAYOo1hRXD_fFx9oa2bqTV_x17i7Y=vajcx1knYNLjdsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 10:49 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
> I'm not sure if this was intended, but passing -1 for sk_max_ack_backlog
> is known hacky config to get max, see __sys_listen_socket().

I checked this.  In __sys_listen_socket(), a negative backlog is cast to
unsigned and capped to somaxconn; there are also in-tree tests using
listen(..., -1).

I could not find the same convention for max_dgram_qlen.  It is not
documented or special-cased, and I found no in-tree user or test relying
on -1.  The sysctl value is copied directly to the u32 sk_max_ack_backlog,
so -1 becomes UINT_MAX without the somaxconn cap.

> At least, this effectively limits the upper bound to half,
> sk_buff_head.qlen is also u32.

Good point.  I'll change sysctl_max_dgram_qlen to unsigned int and use
proc_douintvec_minmax in v2, so negative writes are rejected while keeping
the full u32 range.

Thanks,
Yingjie

