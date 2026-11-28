Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850234;
	b=Ob6lkIk8+vlj5ThUWtqEYnjrIC2z58nEbJMCE7kMO5fSw7xJ3tzeLPYEhfApy4thn5Oq
	 209+lo+GytqF7JLDVv+5fQZQN9KwIk/Qljplp4bwcDGTKAg/TGKghdk+jMZyx/yhNx30Z
	 LaRusoE8NB9qQ98bhlYq4mnfIVQ9OswWh7L+9XYO4eGsTdXJOxbx1/zstS5IPZ6/POyya
	 S9/QS1sxwqCCMs7yQfxtvTWOdemFj9nTeFvPntRMWYLiDqRMfMnZqNzEoEI1hC+R1TwhE
	 XQOAoqkmozOnyRQZpCoMJqYyE5u7wuommZ3KPC2wwUrOwrNmvxtOaqxW/R5ao6ffIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850234;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lPRfmfNF6Iu0goISNYMZA+I07faHUJ3SbWyNgVkLHvw=;
	b=iUz7f+y3csrW9wPbGwQNqfWk23o9InjtUNjU62vlhKCJC9IewCnP5w3FIMRXmhxoXlBH
	 DFTk9H4hpU07qpXVFsVL1xfnhGgZoblH3XgZeSZ8Dk9uoEHyyU136VXTzIkPyaJabCSyn
	 SK/tdEgEnIRDIwiF6rkz+dXNIJEVdFdy+jr0ckcTPBk0KBhx+se69AURwMs6ToIo++d4D
	 Uh2XmpiBEkKxFww/NzUf0cFS2ptOcvfBCMQM3CbcG/nNp/orYlnE1qB8wNCeDKpBj43Jd
	 hEBleyUr7ea9Pr7+8USj8o7HoYtobcVQ+y4mRMp+L8XZNA7wV0Qmwc0uDNFkGsUdCYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=KWpGTeMQ;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D0606A33C;
	Sat, 28 Nov 2026 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 787D0606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=KWpGTeMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795850223;
	bh=lPRfmfNF6Iu0goISNYMZA+I07faHUJ3SbWyNgVkLHvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWpGTeMQcBa7Npwa39fP+eld2QqSVKmOZeTrMhnP/8gFv1S5c6w0UKK9iPN236cF2
	 45AfWqJSpyou20BSrFw8eqPTM1ZlweG/dTHd9IeYa5aUVfLzyrzd0GuOZPMKtS/RzN
	 1H5GNAoJ3ItgIZzgXGEr8cflobwGtMfmQ+pSism4=
Received: from localhost.localdomain ([240e:3bb:3013:1841:8996:c946:cc49:aa8d])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4419DCC0; Sat, 28 Nov 2026 15:17:01 +0800
X-QQ-mid: xmsmtpt1795850221t0v87nkr5
Message-ID: <tencent_39EF7AC456CEB2270310851AD0ECB4891206@qq.com>
X-QQ-XMAILINFO: MCcbKzV4WGxBXNCluSBsbEm0BLuZIqLrA2WC2bmqYZrdJ1kgEKO8rPkqN2YNDa
	 wGMgrvu1dRVO51nUuGcew84lfFirjwLDuWoRdvOled5AcYD2cbtMneaNi3umtEsdZfAPbZH3UBq+
	 1o4YT6AcQfOYpJviRTBAS4mcSfs+zGYte48E+RJQUxnKBoq4jDM45g3Ms/QXpA3Ifyb4n5IdHZl+
	 vItdw/Cf95RkbA0kmxWMjkIKdieeTV3BILBXiWxsSwmYQNJ3BiSpXCc7vpKgwG61+aSg3j+g36KR
	 YBgvkKyQMKCJ/kGh2MypGbabKnTVJzogycAPMD0hKy1ddr0mrhggKH1D63GB+xB2bttLjN7gZYyO
	 q+avw9xPiQoGhvEcTj8liRKxHPkpeWoe9jA+J25tAsm4gu7Vvd+H+R7fMe8sYrp3eZyUSWXhmPdP
	 fKW0DI2IDINY6yge09HLKxGabjRbZJ59MbmH98t+IBzpKCOnrGd0ZRE7XXqgzWWbTl230qbsmwC/
	 Zto2ZaBTMB3myvb0Czv/wZQkd18EEUGn/7uGba3U4M83oTEMhBr9eJ0HJxXGxyAZcnojdt+Mu+pW
	 3nFpb1l62Cu0puM1BTXUz24SGwAo43dx1T7AU/xCPC3aSFxa71c4dHY+1Sgs995shI2rpE6Gh+Vl
	 QSMr8Ql9ucvquNpqtA+ZrXfkdeHB7zNTyTzxw0EyOFM0YEgCiUe8t7LA4mVmyiRr/qnbcTb8J080
	 /LZ4TXDYcUwCgVX98kjWuDYMdwmsex45M99aMBDqJCbf/KEGlhf8s671BnY2qq5D4tJzXnvppLZq
	 aw/0LqRuMLBmwMLeIATZNESdP+w4t/aAvVyN/PSj+Fr7iB8UV0m9JdpdDZM/wMw3JznhF6UBZ+Nm
	 MttM4Z+HNfH9e03jzS1Y71mcfAq3wM+yWqrcnxeKjThlQJUtMpUJgy1PKnHxyZ00MTFtt1+VzX8b
	 dRvUntI9VR/TEIYNsdaNocqlb6mdZv+sTv8ExIEd7eqqrv1fKa7dFyOzJ/eoC5Y3aGeKYMlHez0W
	 SI8ooKTf65QZKjwhA7lMvUXCBwgbW0NIidqXSC0YI1KgXYCTXR
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	badhri@google.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH usb v4] usb: typec: tcpm: exempt Soft Reset from the SOP' MessageID duplicate check
Date: Sat, 28 Nov 2026 15:17:00 +0800
X-OQ-MSGID: <1795912200.followup.tcpm-v4@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <1795204201.patch.tcpm-v4@foxmail.com>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com> <awBIRnc9lBkdVhEK@black.igk.intel.com> <1795204201.patch.tcpm-v4@foxmail.com>
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
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi Heikki,

Gentle ping on this one -- I understand things are busy.

Two small follow-ups from my side:

1. Greg's patch bot pointed out that the v4 patch mail lacked a version
   changelog below the "---" line; that feedback is valid and I'll
   include one in the next revision.

2. On scope: the responder-side SOP' Soft Reset handling still cannot
   tell which channel the reset arrived on (tcpm_pd_handle_msg() has no
   SOP* type parameter), so a complete fix is a slightly larger series
   than the current one-liner. Happy to prepare that, or a rebased
   minimal v5 with the changelog added -- whichever you prefer. If you
   would rather pick this up internally, that works for me too.

Thanks,
memoriaru

