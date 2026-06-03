Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79833CF677
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499673; cv=none; b=iS9D5MgQH/48gxox5CriBsFfvyNI9df+rXzw3wV7U3iXTb0w4cuwZm7lZYaAX/AF4HX5wJeDmov8dmjcUJzc7d1CciuPh0soKtvGWJYUSfsVSmC6NN/YCgEEbHJalFtLUPff8g+C+3CGkWhwdEukJTK7/zPMl5H4PcUvZKk7QJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499673; c=relaxed/simple;
	bh=ndcg9HTiLyWJn+0+Zo7QJd/gIe/Eeiv4cJUP2rhG5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db4/BXjjB6LfgEP5jD/M/Ro2CVnt13eDi/F2jjVV/Vo2Mdo8ULVVoW5SEBXcQo4IBvtlb0WM6VgrkpKmJR11JvW4h3Q3+cGRBZF+gy4n0T1gSL174ZF4otuezOSwLgLu3Be0/q8OkJy3c+/XXmfdngavnuK2e424rkBy7VsYbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgpjHidw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgpjHidw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FA21F00893;
	Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499672;
	bh=+wNM6NZFTfOIUY0WPqES+hsYCoypKEamWs7y3Mr2xFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgpjHidw8oQzDs7d0ir/I/bGN3PfWj6kgvX8cZgabVAf68wU4u6XIOx0GnDbLfkAl
	 52LAu18mqTVHK+E+tAIObfMPrPAuQO/9CWHM5LckfnHQhDC/+tIxTQqKJV9AWcVlIN
	 Jrez92zOTftPVGxIyxf/rzEWUW0dTOJMJM+uAXBzZKOFwxu/pOFUe+N1XJXiJShKlw
	 xAdpEjvPqgePUaBLQBP3iNamnHZpsS9KTC1nkey/ymTWxbZk6ZbiF4h+8KkudSxy+N
	 T/u7OrJGU+JacCgYwH7qUJXNe8dTZAR/MKUWluJDDBtxADFiS9lp/t93YSdsOBnilG
	 AXot26ntrSXDA==
From: Sasha Levin <sashal@kernel.org>
To: Jiping Ma <jiping.ma2@windriver.com>
Cc: Sasha Levin <sashal@kernel.org>,
	michael.bommarito@gmail.com,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] smb: client: validate the whole DACL before rewriting it in cifsacl
Date: Wed,  3 Jun 2026 11:13:58 -0400
Message-ID: <20260603111500.item001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526015822.4076817-1-jiping.ma2@windriver.com>
References: <20260526015822.4076817-1-jiping.ma2@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha
