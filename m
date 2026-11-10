Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328920;
	b=EPZMOJoGF32xt9qu+U5/7uiUdbHeiy58UUH3nL+xmV57EbErz9vfITNwLs/1ryis985a
	 rrFG/1TahO1+FW6+Oog3T8gUhhg/VBn2udADXU4OkiI1nB5GC1eOaanYoxMxqmkUdqABS
	 xptxzagOMqwC0hY55XoXdnh3DELasa99kM0PPfs88AFiRWaOGsIhg9sUb9HIZLM3H1DYD
	 dqf8qItaSLcNwQjtg1+1fDKrXcJWmsaBlYNumK1dC4hQFlQksvduRF6fZxElBgoxyitdS
	 T7UqcxkLi8evtMiP11x3AFKE9P0oU2W430G6CJE178akO4leGKYIr2xNv8lx7Udjd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328920;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ybspi0irVzBObVnvymayoasXUFA6ZUc1FYq9F7jfk0M=;
	b=cPpMh9BLsuFeDj0sbtCdh8uTz1ajF0r7JJtC6m4bJqQnNh6scq4UDDwP2wzBsKYoMhSF
	 Xm/lRsR2UsXrIjBJbaZaPl3qT1BlLUukxeT9pIudlZECLTtKUZnCyGJJ+RSA2rePhMATO
	 cw2SHPVQGqFVPVi80PxHO/QIt2o7qLZylzQDCIfhhSricC/1HYjI1nkNLsv+41risJfSY
	 CphEahHeMguqpRoLZxbMmATGHOPDM9o1IIatk/PStXujntCbBgRo7YhWRt3ZRCAu/BJnm
	 J6Xv9Lszgyt+GZAJBy9MmkW26U7qf5bVS3zx4AIWRT1Hkl/0mtT7R3Qs3PguAzE6Dzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DFKZ+25R;
	arc=none smtp.remote-ip=66.163.188.153
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FB606A200
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169FB606A200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DFKZ+25R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794328897; bh=ybspi0irVzBObVnvymayoasXUFA6ZUc1FYq9F7jfk0M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=DFKZ+25R+hMfA+OelXsBgoP9YUBAEfYECjdFYI6wKdBY0TULnSau2RuJl9cZH7caioJqYi03bAY3i3nDCImIZu8erv7sXQcKj7NQkJomyXjo2woNfQ8f0rWHesY3gJ0oTPXBEJh6ZgHk4vGeB3pj8oeBCSgdbRdPIUVWI+I73RMoUWuxcD/Ft6xwGBopMtZpN74huiDWtQu7ZGKIY/npqf6VvsGwHsbVsH2aQ5kpYyk4rJpUf9VrTNIq0o5IGfTdx/8Y2n0+7AjJuUXDrkiyoZAb0Z0pzr8rSsmDD2BIkbkI3ZpnaTlecwUem/9LLmKUbcpL1ji/Apqx322dPD2eGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794328897; bh=gFlTntCLbDEELEgOcaRbmxFuK8XpymMLrulQKVDRVqy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fxrDNdd7XuXHTSGF4+egQlaXcsqUUx32z8528OdrTqhM6XUZ+/XBq1xAT/blCINA/j5+9MPEQKWDRw9Gd7RXg5vzVkdEsAU5/0rNGEDypMTgL3EoV+B1DgMuRaLIsUD8E4493P+YBVWCHci8+N+yN6D0sLmutqYsaXkn8R8WeTsTeiaynHeTPPANx3QP5qgAUthV7HEeojomNy4Yld8TZkz3rUZJSiBq/Uvcvxq6w4skxAv1Lk6TxBlOkat6kwSXAy2NhliDJHdohyUxvDa9LhS/hp/LD024jq83lQ9iXZBZdHvtoIr1wNbOYEVOhtyD/6s1Urvk8evGMJJcix/itA==
X-YMail-OSG: f14cNqYVM1nYwAlXL0IhP5bumijed33nHCbgTs0pNALSfbKKFkBasRoP8tpS3gx
 y406fp13ndveZe22DYhiZx4KVJy5188t.ZAQnsBsvfENRoZyQ9v.pt7Dav1WGimu_OIjNk1JjuTh
 Lv5_jFG9OSEwPWHYa2qmGhYqGZKDEWdikyTgHKpcjVTFKaaFzJJ8yl0mgAe4BlPOeod3iUrFDDtz
 D4OPIHFmcERjp9a604TkEM40aTBIawTnIHtWqOq1XQLZTV4C_3_aIV.QcaGtJTSSX3XMHU3pwCBf
 9FjVlfWMbkUgp7fiBUwdMwiMEIZ64ZIOYxhaajl3N27vEuBiMXwCMtxapwrCbfBNL9ULSYnjuIQ_
 e3RoxDmsdVSP.u7ptV8EcPsd0x0vABGNFwVy8oiomeyf5MihZzNM6otV5Y8ydXoJSK4CqlckPxvG
 nhD0RoO_q2Rq0W49a.7VcYHelsHWFSKx2KVSUreL5SE3bssO3ntQk2cEjHa6CkkJqrPNYxLTfY3y
 3UIAZUuKEsthuZL5ew0vr56qNq8CA0SCAeZUP5vjEYP2AcT5rbcdUMCESDP7fHK.FQs_fCMM7Dn.
 Q3s2xlAHwawk3eQlebpOaBsviXWl7jG9OwA6KwfCopRY2Nu9DvM0wGeZL6JcGftwg.19olJgu9PO
 ndhmpn6cnhWJn1Psa5ZNm5_iOFnefjlQTJDeF8a5lDNkTRT76zNr93_XZOBzc5.0WKOlpvgoQfep
 a1l5xk1dOLMte9ZEcVzf3HRmIujdCTQH81sBid_QI_EdUfknKxtYdXiNniEjfLmHM3CrK387opsw
 qxY_XZdU28BiGbsxIVwMnNnWYvSmZzcSnBieUA4oGF4zQPqTB7Q0mFULhRxW5Yf14_pPgo.474zw
 MXP9KxUTdyhkfmE_Nw2fqBt7iuYqETKr3HHrDPNz6R94nCic0GLnFajLhki7LRARiBvmJ1ZwBrdw
 lSto2p4Tj_gIEWxlt4eoJUWRIhrPt56ju.NtvwJTj81CJ.9hrHkQ_Sc9y27db121HKWH.NkZ6bl7
 XeNjc_Xh6VuAA8B97XMeYqQiqTmnxcXZZHA5s_RCHQg81e5MznvwmePddNFjkUKoYKOyROTjzr8n
 Euo92hvlaemGUK1odQj0CQcLi6XvNdsPzNQmcwnris.b3kJCJyCMufltww4yJh8c5xT2YXTKWF2N
 7RX.LPotqzovl_AN55sOC.ZGvE42jDES_cPCeWqBYywfzL3OUwXnsbrH1NSB6iCyeacMT8JECckx
 PRfMgairVFbntC55HLROpi0jaJttKX6hXFTL48PC6ozd3ZzevuBWzH8OP5ZWxAKTDj8WMU_it7GM
 WM5WA7itFNwhfnNBwsGxbW_Ms2POiwNfZ0xz041FGOl9kwxSIhHIWH1iOja_T0XQCAHRCjt_uiBz
 VVkeH7kD9tzDCbFM6pJ47i8fhRgDUiq17vviYfeZr1Kr6Ky0S8SkTjU7KQ_n7nlyemXmm1XGAQZS
 J1h.Qmkj_ikmRjkmJyizztj7pEdmy_JbTdxWomnIB_KZ5ZF91JngaeaRJNmRy5YyrOXC7tyURDel
 czjl8oxakTTGq5NdUYT2hpLDvWSaPzuV7NhrUAkWbGHPMvyMSI4XLhHz5hBGjH9CZkOSexQDCNUD
 WgFX3bGqTJImA5xLSw8J6a2aaL4GgeWLXXU8JIxe03TMbdSI8sfA5H6ZBKhryp9FnmAC.FtR.b_L
 NZh1eTvMIw2Em0aLZ9vftASyKXpIbkeHfbqTzmZ_bthIiOWclTKWFOHNfDFne0iH0yKrNVc5uqdI
 jejiqUtNB0PbqdlWlpvuYwds37pKIkIjbAoTQfTdvaE_w.cqvsFqYX_F706eFlTsgo4DSTB4ls5I
 fuL1rminsYfKzycq7VXMvFdaemIU3Tf2BTOnPARorm9FOpwMp6qekg9.jmDi1YcGufwI_3r2eG24
 eDQXMfpu1EBMAZfuQlBcde69_9O0ASwNpuiwOa5v3P8nFyvls6KYJ6Z0iwUdCOg.H9j3XVGUX42s
 99DcSoqrleMPn2KCbcsXbAm9vvjqduORB2BaiXz8Xiag2hMhqp1SHS8_57dOlg6gMnPvi6PQDiCm
 mMoyPu1OMaYe_zFRXOjNtLavvwpsfdUvdELuKXa9DmRMA9ISvje8UYyYVYFamtED1OFudSYW4Erh
 q.JxzUvX_sZj571lO8QPWAMNHKHn0acKXTayiufqUVG_jNw03ZA.SieoxJnWmrfdick8KgZr4zSb
 sOZybakVvlBG_i.T9NN_SQlATxPLjRZbTYNOPlldWfr38p.Ryq9kfe7udbMAeVAF_OdNEm11D0RK
 eMfm5UivZOIyzsp4NsWMSLMG1WcOLAX8.NA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4647b4e5-10c3-4ff0-9fd5-fa634f8860ed
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 16:41:37 +0000
Received: by hermes--production-gq1-fd7994565-2s7m9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID daaf98ec744735fc8c9286a06b483fbd;
          Tue, 10 Nov 2026 16:41:32 +0000 (UTC)
Message-ID: <0f1b2571-c573-4762-92fc-e3a8e4695f23@schaufler-ca.com>
Date: Tue, 10 Nov 2026 08:41:30 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Eric Dumazet <edumazet@kernel.org>, Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
 <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/6/2026 3:06 PM, Eric Dumazet wrote:
> Le ven. 6 nov. 2026 à 22:40, Jann Horn <jannh@google.com> a écrit :
>> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
>> socket, and tries to remove CIPSO options from the middle by moving all
>> subsequent options.
>> That's not allowed - ip_options_rcu can be read locklessly and must always
>> be consistent. For example, ip_options_undo() reads trusted offsets and
>> length values from the options buffer.
>> Fix it by doing the modification in a copy.
>>
>> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
>> propagate memory allocation failures.
>>
>> Triggering this bug requires that the system is configured to use CIPSO.
>> (Setting up CIPSO requires privileges in init_user_ns.)
>>
>> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> I've sent a separate mail with a reproducer to Paul Moore.
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> Side note, not for this patch: Smack calls netlbl_sock_delattr()
> and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
> not exclude a concurrent lock_sock() owner such as
> setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
> old inet_opt. This already exists in the "cipso only" branch of
> cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
> the copy branch has the same issue.
>
> The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
> this from lockdep. Smack should probably use lock_sock() like
> SELinux does in selinux_netlbl_socket_connect().

Thank you. I will give this a try. I would be happy to accept a viable
patch from any of the numerous people who know locking better than I.

>
> Thanks !
