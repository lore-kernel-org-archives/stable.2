Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928807;
	b=CzOSVBEnTM6QR7XNytnuEU42fLrirJeB7J41QRzDTzz6YNCz/rtS8iY40mQYNHjYkbtU
	 f4mG7m//XnvefVMPPRhbccQcZOvONrtTUEHQeRLYIqGhveqIT6zxo2XFIIRF8Muoc/CFC
	 obSFrv4jODBJVV8NyNHI284R4PLyqVV7UYohBgdHH/8ki83QvVeMGFqtSHC6kZI7WWgpR
	 k7vCwBKHSII18R8vgSwbKewSmcfK2cBLJnMLB5hA9DXvv0hBysQyfBwALE5NhakPHJC1N
	 t/iDnRhDduNaGcD3H+WBfwB+JIJYT+NSMG1vueBVrmus87gJTv6kF1oD7AlneJoxfNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=KLQlagsRKAQ2szx0aaP3EES/xqizR2EBTnrR9DEFR+8=;
	b=nYztVyYTyBXV58toJzGnuFx4vE4FG0QYz8tD21V2Mth1CfNfDn5xY+/b2HjWfaOjxyZ5
	 7SBNBJXaM/oDGfEgfIZZtXPsayuUYPqt8EiYR9/1/IlP6J9VC2A054ut31lHLTd+4XXBb
	 EdAfEcSKqtNsby1ZwIz5je+uvQbyi74tECTOFi+yQoOq1IxQ4cU2AqLFiCoVqarwuqr3z
	 D5tIlltPZMj19DDwXy1bTj/ICEgUbrJUwqBn3y00ZdLxCOKsV69lpmU93aAs+S01o5eua
	 nTs6TkFtIuXBd2MOx51P43g+10qKddjM3XnEv3xZQlNREYw1nq3hd/qbqirMhG9z4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nfkCU2Kd;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7461606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7461606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nfkCU2Kd
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1429951eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792928806; x=1793533606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KLQlagsRKAQ2szx0aaP3EES/xqizR2EBTnrR9DEFR+8=;
        b=nfkCU2Kdxkd3iWFJBpSLP2e8OAiGoR2tpGgzYi/AeL3Vj+rxFXYuE+Dar8KW4GcRSi
         JQ4MdVhT5seQOz5Ro6Mj0ALxAf2RtHYgIx0jaeTBcH0AUPe2l2FLY4axAEzKg3omfZQI
         5iKPW+yCGbh4X7nRmlr/e0VWnaxeJg4p+gumwrRObawfUAZpPYl3PxMvDgmzjVklxobL
         g8JCdn6uG+cdJrQTzVFjF2uELYODugndM9yoDohkFqi2xFkbDidrgpXMjAgL2FiScE2u
         ooFXZQTkpHRzREcBDeLOF4oIQAkM5BK7wj9OBv8c9WmW7XH2brShZss7ygw4toBjWjBJ
         2d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792928806; x=1793533606;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLQlagsRKAQ2szx0aaP3EES/xqizR2EBTnrR9DEFR+8=;
        b=YFjwFOKcNtMLOUsYYJUGcCPK5eEDHnCzhY4KaYFVs9enLrhdo451fMsCb+yCkcRZ++
         A/+XU1apqOiuczaYWUSz/sOZsSo0rIv991BeKKCXOnY2DdUPxDwBAe118NjoSOdFtyEp
         ArqYn93vkCC1wNZVfH8PGS645nLdwa/yW/qJRga3UNDlDZJ2NAJt/PDGzbSwG0Ga7Sk7
         yy/vE0HkB7MbRyUhv0/e0Hm6geS8EzefezaQskjGgFniPGSSrGLwfjQyebSw1nJopT+v
         BZ3kSaJFIppy1AzTo8ZBxpbOIfPkdNEB11Jl7uCgVaBry2Wa+T7SD/hTQ9EpO35qijjI
         5E6g==
X-Gm-Message-State: AFq9FYJ1YDv46DvAVN4Yu7vLNLsDCwiFI5i7PJgjdK0Br0DvSp9dQE/o
	4tq8KZBDh5PZfMgoLLGLa80BH+XQ1A9DdHlBTSsJN7PXCjDxMzqj34mJ
X-Gm-Gg: AYBFou0QkYZtt5EMeN5GSi0j/DZCxhTQYDpaJIN319kfo0EGrxHhHMl1e+UHGLeqIJn
	X4gV7VBcgzNebcO34yzZuQD1yUV4++yIP0KbGOrQ7JtiD6fAMETpwawTFmAVYTAQX5PJhOa7fYX
	MPUEV+1Bkx4LjepRW4c3FTyEys2uV7maPhpJoLA4nrn4tD4FgheXrKuZbFJm2pO9ZEJGlvv0XH5
	e2A0BWgyGpS9Z133msCDTaz52vwtXZaZZq0TRp+XU8TwcZIWxbgFsCLNs19oIgVmNNB4sBO2XDv
	3VZ+6vexhBndvVhMMF6y8aM5nfQMnQyP/EHVHoKBmmYrd6XNV3gRsSbyTyTc7cfZvUVgnOX87c/
	z0mb7KuaDcfq+NJCnjVe8uzN/x2fhAUjKMZegaf+/mGta/hdJAspExRAr1LiInO8o1QHdyHUbGX
	ybI4VbkMqghgYogHTHuEgu2xNbiT7otuDRZ6Edg4eCfNG+tlgfDJsrIhqwHCKoiMcNBCKDq702Y
	tsRM5oR00+UZgiMYtOrMLEdWf9GM+1DIQhlEbVrOVzSZARfVE8eu/Ab7WV8EoNAgfE=
X-Received: by 2002:a05:701b:4306:20b0:184:1898:add2 with SMTP id a92af1059eb24-19935625958mr5098384c88.26.1792928805488;
        Sun, 25 Oct 2026 04:46:45 -0700 (PDT)
Received: from ehlo.thunderbird.net ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm15542281c88.15.2026.10.25.04.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 04:46:45 -0700 (PDT)
Date: Sun, 25 Oct 2026 19:46:40 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Roger Lu <roger.lu@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_soc=3A_mediatek=3A_SVS=3A_fix_device_re?=
 =?US-ASCII?Q?ference_leak_in_svs=5Fadd=5Fdevice=5Flink=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <230b2dd8-8d8f-4b1c-ac9f-2c1eac636751@web.de>
References: <20261023082948.1854252-1-coiaprant@gmail.com> <fa60e7c4-d8ca-4ff4-a56f-6a6e2bfbf3cf@web.de> <9AE974CC-F342-42F0-84A3-D72C3A0326C2@gmail.com> <230b2dd8-8d8f-4b1c-ac9f-2c1eac636751@web.de>
Message-ID: <2E8D967C-6CC3-44C9-B447-9D977E7A6538@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 25, 2026 7:42:51 PM GMT+08:00, Markus Elfring <Markus=2EElfring@=
web=2Ede> wrote:
>=E2=80=A6
>> __free(), DEFINE_FREE() and return_ptr() only appeared in v6=2E5, while
>> this driver dates back to v5=2E19 and the fix is tagged for stable (fir=
st
>> LTS is v6=2E1)=2E Converting to scope-based cleanup here would not comp=
ile
>> on 6=2E1=2Ey and would force the stable team to rewrite the backport=2E
>>=20
>> So I'd prefer to keep the explicit put_device() in this patch and leave
>> the __free(put_device) conversion to whoever owns the driver, as a
>> separate cleanup when the stable backport is no longer a concern=2E
>
>Would you eventually like to become more involved with corresponding
>source code transformations?
>
>Regards,
>Markus

Hi Markus,

Thanks, that's kind of you=2E I'll keep it in mind, but I can't promise
consistent bandwidth =E2=80=94 my kernel time comes in bursts=2E

PCS is where most of my remaining TODO list is, so that's where I'll
spend the next chunk of time=2E If I get through that and still have room,
I'll take a look at the other device_link_add() call sites that have the
same missing-put_device pattern=2E There seem to be a few=2E

Regards,
Coia
