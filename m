Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16203955CB
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315126; cv=pass; b=Obs08VsiN7FFpQ5kYYe4mz+1hc0YAEGOymO75NFvb6zvv3LrXceh74X4jTTbz5xqEeNlJfd0siOoxGYQiW6CnGsdzRQn4pjJnZ1IjNfagfEgnnsFPLEBPVrg8vBZiUR6MdwF/lSRt20a7kAVQzhNT8Y85mVmz1muWybMi1bBhDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315126; c=relaxed/simple;
	bh=Hl9knlG4/9ywK5hPuGY9eJmWuv7uoveTetSEz3BOFyI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nlrjWwHMOE5skLkJ897O1OI3sDXi8/VhOAcV2a3EFGMpS7dTaP/zAdWVqHSYrts6VDMGklr2bzfeHP14gqsz4+Wwgariop98AYXp5gTcdy0i3h+IQlsA2yodISEqlNsSkGx+krKBxowwacUMraLrceKQjex9kGAriHG8jNS6imA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=safebreach.com; spf=pass smtp.mailfrom=safebreach.com; dkim=pass (1024-bit key) header.d=safebreach.com header.i=@safebreach.com header.b=WYyA6iHw; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=safebreach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=safebreach.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=safebreach.com header.i=@safebreach.com header.b="WYyA6iHw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so292321566b.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 02:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792315123; cv=none;
        d=google.com; s=arc-20260327;
        b=PtCEFVBfCHpYbMsaJQfMWeBBdKwul2XIePq0cAy+FlHQ4mGUwvXTBn0GAdmlL991mA
         6dzGfEAGcGzhZg0V08YDUlQTkJyI2ADTXOqPVoqQVT84pT1WWF+JdKa8bN64ezWNM3dN
         xLdXH9/CQAVhYuyKirbdXb7gv6Qc4TC50DLVngd99Ph/BVJM0yAjnJVy/lOEOVGJl8mu
         Gg2WoJfO/v2vAl2JyPFZ4db8MEwhN3K/u7BMTIWmwv5b/BA/K/50DVIFOc2RlGSQZMQ3
         okAfgtkA1uHE+1qXP9brP+x0X0bv+jX/bqcvM4EGe+5S6PQmNFbRUAYFKc5g7BmpiQ6D
         Hi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=H/fFhaq2RFRjuIvCWE9nRJGfxKNKEB9NeriN24IeNGc=;
        fh=P3UluCj88NwkXz2slhL2SyOd7gJcUKwxpU9LBu4edYs=;
        b=qeNUoiOYqGYv/n32QMF42PKpY5hRx6a1k4TU6jubJjm7kRaJkDGj5Wx5mn2vUgoWHj
         FQGeH5YCZMwOzNAaAS2/TnRnyWXZ1jvOizfkweCExUx+b1+zHmqISE0PeeT8/gJmN4hu
         etaTeo/W289x1qG0/+A+9nSOoSuXhMIacNNEa3K6uURhsr20SDV8IeecXCaMY9VKodB2
         2jMNJ8RYV7b6mxGGXGHslksfaeOL/biPEF0dihJdjagvWHeO+IbJLR1NQJAXvF01flsp
         7Ca19Ix+/hdlXNksJWtOgPkOtK4KzE2cJXrJ4p/fkT3NS/dxKCLIcV6Ee6feLQq52gq+
         EqBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=safebreach.com; s=google; t=1792315123; x=1792919923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/fFhaq2RFRjuIvCWE9nRJGfxKNKEB9NeriN24IeNGc=;
        b=WYyA6iHwPQldnN7DhtEGHoumn+wcB9Grt2p1EM5JOI+QxQaByr/aKxtOmxtf99lqqY
         3ETLBXWSR5Bx97KxNMi38A3uBWLPz4MVSbFTfakyPAqNUI5C0UeVI7YGVPAt+OBMkf7T
         aruvLT88LHxnF99JuASAXXD3BK7J3lH86vkps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792315123; x=1792919923;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H/fFhaq2RFRjuIvCWE9nRJGfxKNKEB9NeriN24IeNGc=;
        b=hGCH0p2kD/HygYIxy4lnW2Epr8yL9AX1NSrUQo4vZDcODgvUdpnWhulfDXG8JiUgjg
         w8Jb+WIPJ2Su/gW+BBtIbYE1Z/xr0M8rYbhtd09ZMr6LOD79JLw7aZqDziadfZTmIvOt
         dsCFdyKNVIdi3ElvIEaRh+hYcP6ee4ajgBW+J5djHx47U/eu7jYRUvoSQRuI01rjkGrN
         xbgilOtgix2T9GgqzED3Y9WZQLvX2lbVuZmaDK+httfv4I+autrkgI/ARgD+HJAXOrR2
         zpL4JOlXiVkcpFRv5VmUSI9pmmIon0LdyqH+HZB/QLm7e0ZWfLRRBS5lOzYKw4stsIHc
         x42Q==
X-Gm-Message-State: AFq9FYJKxgY7iPZJgBk5s7TFDY4mzOfPMTjbhYvle23KfoaftKZ/VRD+
	/Wl71yh9YLWtnDZnTASRSr3cMgPmILrvcpYG0CHuLCb6tfivYz8yl5CbwODHA+Kt96EQ+nU8Cco
	gpttWm5eu/ElOiuSuQ7RCOetnbmvfOT7sNyBmt/z/vwX+8sQWyCWI7sEuhg==
X-Gm-Gg: AYBFou1yd157NLiMncqJsw0VTWsDJdpKrxxh5QojH92hwYoUhneceKM3p1RduPIBvq0
	KeQ63pXLbgzzlbaTtaekyAQnujBHnIySF7uFKk38nWBc8oQL8ftjo78DMNP5SiQUy47KbShvRSS
	pyCz4ZXCONDbRfx/huQ+RZZRCiCPSuQjiRRtRvCfgPG6cGgInrrAJkX9DxXIiJLl72HslwJ7J0T
	4m8fDKnC7tsgAxhZaPfUY/FC03COGX/Vr6XO4TB7zJh/xF6XndJIl30FZwGzj6f3QvHPKUL6Fiy
	6ocgF1WCnMkXW/3h0viUUEHl+oh0wC/XJVSZaEkxgFq4S9J1B4r00x0=
X-Received: by 2002:a17:906:9c93:b0:c2e:204d:9490 with SMTP id
 a640c23a62f3a-c40217bfed6mr616038366b.17.1792315123134; Sun, 18 Oct 2026
 02:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilan Dudnik <ilan.dudnik@safebreach.com>
Date: Sun, 18 Oct 2026 12:18:33 +0300
X-Gm-Features: AclHuK8jBpd4fOYBK4rGGeRadJy1WR4qtfRkepjNBzPoZfIt3xn_lQ-UjczWrcU
Message-ID: <CACdWfbyqY_rUJ_Qj0HvuHGEb-PBjwj6eKYCY+r1WZtNnsWuhiw@mail.gmail.com>
Subject: Subject: Request backport: ksmbd: fix heap out-of-bounds write in krb5_authenticate()
To: stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

Please consider the following upstream commit for the stable trees:

  23a0be6a84a3 ("ksmbd: fix heap out-of-bounds write in krb5_authenticate()")

It was merged in v7.3-rc1 without a Fixes: or Cc: stable tag, so it has
not been picked up for any stable release yet.

Why it should be applied:
When SMB2_SESSION_SETUP is processed as a non-first element of a compound
request, krb5_authenticate() computes out_len without subtracting
work->next_smb2_rsp_hdr_off. This overstates the remaining room in
response_buf, so the length check in ksmbd_krb5_authenticate() passes,
and memcpy() writes the Kerberos AP-REP blob past the end of
response_buf into adjacent kernel heap memory. A remote client holding
a valid Kerberos ticket for the server can trigger this during session
setup when ksmbd Kerberos authentication is enabled.

The issue was introduced when smb2_sess_setup() started passing the
compound-offset response buffer to krb5_authenticate() without updating
the out_len calculation:

  Fixes: 98422bdd4cb3 ("ksmbd: fix out of bounds read in smb2_sess_setup")

Kernel versions:
98422bdd4cb3 was backported to all maintained stable trees, and the
vulnerable out_len calculation is present in the latest releases of
7.2.y, 6.18.y, 6.12.y, 6.6.y, 6.1.y and 5.15.y. The fix is a one-line
change. On 5.15.y the file is fs/ksmbd/smb2pdu.c instead of
fs/smb/server/smb2pdu.c.

it's a resend because the first copy was rejected for HTML

Thanks,
Ilan Dudnik
