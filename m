Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D1349CE8;
	Sat, 22 Aug 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384898; cv=none; b=S+BG22FGK6mNhSLwidNLwj11GEi9gBtqb4B7O1O8zxzpHh7zk6u1V3nWg478bfR7YEU8kiVjWhgjCp+7XlPHKjvHaRY9kmcqzjsKf+qT9PRDjTlUq7MSQ+hhViYKpuStHAc4psyC93vlKLJaNiPiyBx9bOiQgrZ2VGufmOTVlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384898; c=relaxed/simple;
	bh=MI/aQvPVfPBCeDSzjkwc78B/FinAxNtT3gTBeJuBA5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+CoeyEmUb++1yFQEbXp6DDAPA6E3PvpMb87T79oBdBBpkk1oX9VZQngIcvmypyFSHLC8Jq5EtrEkqWziqz89H/CT/GNAvNbMvtG7bv6RfuIwfiEH4wXqScQi3blmCbq/EDX8gxDkYFjsJb6yeWtk818BcLcpi+w0WhShoQlUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=D/95uWDm; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="D/95uWDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1787384881; x=1787989681;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=MI/aQvPVfPBCeDSzjkwc78B/FinAxNtT3gTBeJuBA5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D/95uWDmpjTyiQmsHaaYwLVKBIVB++W/lK00QfKfn32mO68ryPnAFz45Jt0qTuu1
	 ZjC5BCveZuPNFrPUQIsAcltoyEua/u4X48gSzp0GOyimnGXRfSP4DpU/s4vcxULTK
	 Lbj/U5fkDI7yOUQzn1bnWNO2lI5E/1X9cjcJuNoSBK9ZM1nK5JIj0MqmE3L93ZItH
	 fqPQbOr7CDh/jYzraBUqii3kAzrrM1sOrGJZwdyYBYiZ68DG/BUBWGjJalRnY36nD
	 SwRKTv3exTmoPYCzZ3iqbN+Uz3+TBO810Clg8WJQI7EBQA2L1gonsu/nppo9zwFLR
	 HizGF6UV9UQk3IoVqg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0WwO-1wldHY3Rtk-014F4b; Sat, 22
 Aug 2026 09:48:00 +0200
Message-ID: <ef89a8ba-af41-425a-90e5-77061fec3f9f@oldschoolsolutions.biz>
Date: Sat, 22 Aug 2026 09:47:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
To: Marek Vasut <marex@nabladev.com>, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260822072556.490594-1-marex@nabladev.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20260822072556.490594-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zAb9tValz/hqkmVMlt/xm6apfcKsza9+II/rUly8dq1Ci78Wpe5
 RFwfvViquajJji15774QvMVVIGqtKeUlxD8eLhJlGbcGJDtxLs9BBbxTZSDV7UdUgSEhXZI
 rNUfOCmST1WZlFfCjYfZVNLINf8UjXwYvBBsUEV59KV8p4gjUHDpuyGQXUrk2PFiVyKWq6r
 gwjN4McpsK7Au8cumndwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LV/h/mf4Y+c=;YUBrpIPxY5sAiBHSLVOhEtHHHXT
 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
 ueW6GhOqXWgqNLJFWarhU7+yGB4venpPe8okRwI=

Hi Marek,

On 8/22/26 09:24, Marek Vasut wrote:
> This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
> duplicated mux switches"), with fix derived from usb: typec: mux:
> Fix typec_switch_match() .
>
> Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux swit=
ches"")
> - Extensive test by Jens https://lore.kernel.org/all/8bdf6062-8ec2-4c30-=
8463-0368d3a0f1ce@oldschoolsolutions.biz/
>
I applied both patches and compared to my tip of tree, same except for a=
=20
newline. Also did a test on the Lenovo X13s (sc8280xp, gpio mux).=20
Therefore justified:

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens


